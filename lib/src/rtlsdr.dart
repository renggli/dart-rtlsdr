import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:more/collection.dart';

import 'ffi/bindings.dart';
import 'ffi/types.dart';
import 'utils/exception.dart';
import 'utils/isolate.dart';

/// The RTL-SDR device.
///
/// This is the main entry point for interacting with an RTL-SDR device.
///
/// Example:
/// ```dart
/// // Open the first available device.
/// final device = RtlSdr();
/// try {
///   print('Device name: ${device.name}');
///   print('Tuner type: ${device.tunerType}');
/// } finally {
///   device.close();
/// }
/// ```
class RtlSdr {
  /// Returns the [RtlSdr] device with the given [serial] number.
  ///
  /// Throws an [RtlSdrException] if no device with the given [serial] is found.
  ///
  /// Example:
  /// ```dart
  /// final device = RtlSdr.fromSerial('00000001');
  /// ```
  factory fromSerial(String serial) {
    final utf8Serial = serial.toNativeUtf8(allocator: malloc);
    try {
      final index = bindings.getIndexBySerial(utf8Serial);
      RtlSdrException.checkError(
        index,
        'Unable to find device with serial "$serial"',
      );
      return RtlSdr(index);
    } finally {
      malloc.free(utf8Serial);
    }
  }

  /// Creates a new [RtlSdr] instance for the device with the given [index].
  ///
  /// The [index] defaults to 0, which corresponds to the first available device.
  new([this.index = 0]);

  /// Returns an iterable of all [RtlSdr] devices connected to this machine.
  ///
  /// Example:
  /// ```dart
  /// for (final device in RtlSdr.devices) {
  ///   print('Found device: ${device.name}');
  /// }
  /// ```
  static Iterable<RtlSdr> get devices {
    final result = bindings.getDeviceCount();
    RtlSdrException.checkError(result, 'Unable to read number of devices');
    return 0.to(result).map(RtlSdr.new);
  }

  /// The device index to identify the device.
  final int index;

  /// The name of the device.
  late String name = _getName();

  String _getName() => bindings.getDeviceName(index).toDartString();

  /// Tests if this is a valid device.
  bool get isValid => _getName().isNotEmpty;

  /// The manufacturer of the device.
  late String manufacturer = _getManufacturer();

  String _getManufacturer() {
    final manufacturer = malloc<Uint8>(256).cast<Utf8>();
    try {
      final result = bindings.getDeviceUsbStrings(
        index,
        manufacturer,
        nullptr,
        nullptr,
      );
      RtlSdrException.checkError(
        result,
        'Unable to get manufacturer of device $index',
      );
      return manufacturer.toDartString();
    } finally {
      malloc.free(manufacturer);
    }
  }

  /// The product name of the device.
  late String product = _getProduct();

  String _getProduct() {
    final product = malloc<Uint8>(256).cast<Utf8>();
    try {
      final result = bindings.getDeviceUsbStrings(
        index,
        nullptr,
        product,
        nullptr,
      );
      RtlSdrException.checkError(
        result,
        'Unable to get product of device $index',
      );
      return product.toDartString();
    } finally {
      malloc.free(product);
    }
  }

  /// The serial number of the device.
  late String serial = _getSerial();

  String _getSerial() {
    final serial = malloc<Uint8>(256).cast<Utf8>();
    try {
      final result = bindings.getDeviceUsbStrings(
        index,
        nullptr,
        nullptr,
        serial,
      );
      RtlSdrException.checkError(
        result,
        'Unable to get serial of device $index',
      );
      return serial.toDartString();
    } finally {
      malloc.free(serial);
    }
  }

  /// The internal device handle, or `null` if the device is closed.
  Pointer<DeviceHandle>? _handle;

  /// Returns `true` if this device is open.
  bool get isOpen => _handle != null;

  /// Returns `true` if this device is closed.
  bool get isClosed => _handle == null;

  /// The device handle.
  ///
  /// Attempts to open the device if it is currently closed.
  Pointer<DeviceHandle> get handle {
    if (isClosed) {
      open();
    }
    return _handle!;
  }

  /// Opens the device for interaction, if it is not already open.
  ///
  /// Throws an [RtlSdrException] if the device cannot be opened.
  void open() {
    if (isClosed) {
      if (!isValid) {
        throw RtlSdrException('Invalid device $index');
      }
      final pointer = malloc<Pointer<DeviceHandle>>();
      try {
        final result = bindings.open(pointer, index);
        RtlSdrException.checkError(result, 'Unable to open device $index');
        _handle = pointer.value;
      } finally {
        malloc.free(pointer);
      }
    }
  }

  /// Closes the device, if it is not already closed.
  ///
  /// This releases all resources associated with the device.
  void close() {
    if (isOpen) {
      _closeDataStream();
      try {
        final result = bindings.close(handle);
        RtlSdrException.checkError(result, 'Unable to close device $index');
      } finally {
        _handle = null;
      }
    }
  }

  // Internal stream controller of the data stream.
  StreamController<Uint8List>? _streamController;

  // Internal receiver port transferring the data.
  ReceivePort? _receiverPort;

  // Internal isolate reading the device data.
  Isolate? _isolate;

  /// Returns a broadcast stream of the device data.
  ///
  /// The stream works with a generator that pulls data from the device and
  /// pushes it to the stream. The generator is active only when there are
  /// listeners on the stream.
  ///
  /// Example:
  /// ```dart
  /// device.stream.listen((data) {
  ///   print('Received ${data.length} bytes');
  /// });
  /// ```
  Stream<Uint8List> get stream {
    RtlSdrException.checkOpen(this);
    _streamController ??= StreamController<Uint8List>.broadcast(
      onListen: _setupDataStream,
      onCancel: _closeDataStream,
    );
    return _streamController!.stream;
  }

  void _setupDataStream() {
    RtlSdrException.checkOpen(this);
    _receiverPort = ReceivePort();
    _receiverPort!.listen((data) => _streamController?.add(data as Uint8List));
    Isolate.spawn(
      readIsolate,
      ReadIsolate(handle.address, 0, 0, _receiverPort!.sendPort),
    ).then((isolate) => _isolate = isolate);
  }

  void _closeDataStream() {
    bindings.cancelAsync(handle);
    _streamController?.close();
    _streamController = null;
    _receiverPort?.close();
    _receiverPort = null;
    _isolate?.kill();
    _isolate = null;
  }

  @override
  String toString() => 'RtlSdr{$index, $name}';
}
