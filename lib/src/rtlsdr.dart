import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:more/collection.dart';

import 'ffi/bindings.dart';
import 'ffi/types.dart';
import 'utils/errors.dart';
import 'utils/isolate.dart';

/// The RTL-SDR device.
class RtlSdr {
  /// Returns the [RtlSdr] device with the given [serial] number.
  factory RtlSdr.fromSerial(String serial) {
    final utf8Serial = serial.toNativeUtf8(allocator: malloc);
    try {
      final index = bindings.getIndexBySerial(utf8Serial);
      RtlSdrException.checkError(
          index, 'Unable to find device with serial "$serial".');
      return RtlSdr(index);
    } finally {
      malloc.free(utf8Serial);
    }
  }

  /// Constructor for the device with the given [index].
  RtlSdr([this.index = 0]);

  /// Returns an iterable of all [RtlSdr] devices accessible on this machine.
  static Iterable<RtlSdr> get devices {
    final result = bindings.getDeviceCount();
    RtlSdrException.checkError(result, 'Unable to read number of devices.');
    return 0.to(result).map((index) => RtlSdr(index));
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
      final result =
          bindings.getDeviceUsbStrings(index, manufacturer, nullptr, nullptr);
      RtlSdrException.checkError(
          result, 'Unable to get manufacturer of device $index.');
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
      final result =
          bindings.getDeviceUsbStrings(index, nullptr, product, nullptr);
      RtlSdrException.checkError(
          result, 'Unable to get product of device $index.');
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
      final result =
          bindings.getDeviceUsbStrings(index, nullptr, nullptr, serial);
      RtlSdrException.checkError(
          result, 'Unable to get serial of device $index.');
      return serial.toDartString();
    } finally {
      malloc.free(serial);
    }
  }

  /// Internal device handle, or null.
  Pointer<DeviceHandle>? _handle;

  /// Tests if this device is open.
  bool get isOpen => _handle != null;

  /// Tests if this device is closed.
  bool get isClosed => _handle == null;

  /// Device handle, attempts to open the device if no handle.
  Pointer<DeviceHandle> get handle {
    if (isClosed) {
      open();
    }
    return _handle!;
  }

  /// Opens the device for interaction, if it is not already open.
  void open() {
    if (isClosed) {
      if (!isValid) {
        throw RtlSdrException(0, 'Invalid device $index.');
      }
      final pointer = malloc<Pointer<DeviceHandle>>();
      try {
        final result = bindings.open(pointer, index);
        RtlSdrException.checkError(result, 'Unable to open device $index.');
        _handle = pointer.value;
      } finally {
        malloc.free(pointer);
      }
    }
  }

  /// Closes the device, if it is not already closed.
  void close() {
    if (isOpen) {
      _closeDataStream();
      try {
        final result = bindings.close(handle);
        RtlSdrException.checkError(result, 'Unable to close device $index.');
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
    _receiverPort!.listen((data) => _streamController?.add(data));
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
