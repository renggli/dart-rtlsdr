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
  /// Returns an iterable of all [RtlSdr] devices accessible on this machine.
  static Iterable<RtlSdr> get devices {
    final result = bindings.get_device_count();
    RtlSdrException.checkError(result, 'Unable to read number of devices.');
    return 0.to(result).map((index) => RtlSdr(index));
  }

  /// Returns the [RtlSdr] device with the given [serial] number.
  factory RtlSdr.fromSerial(String serial) {
    final index = bindings.get_index_by_serial(Utf8.toUtf8(serial));
    RtlSdrException.checkError(
        index, 'Unable to find device with serial "$serial".');
    return RtlSdr(index);
  }

  /// Constructor for the device with the given [index].
  RtlSdr([this.index = 0]);

  /// The device index to identify the device.
  final int index;

  // Internally cached informational data about the device.
  String _name;
  String _manufacturer;
  String _product;
  String _serial;

  /// Tests if this is a valid device.
  bool get isValid {
    _updateDeviceName();
    return _name.isNotEmpty;
  }

  /// The name of the device.
  String get name {
    if (_name == null) {
      _updateDeviceName();
    }
    return _name;
  }

  /// The manufacturer of the device.
  String get manufacturer {
    if (_manufacturer == null) {
      _updateDeviceStrings();
    }
    return _manufacturer;
  }

  /// The product name of the device.
  String get product {
    if (_product == null) {
      _updateDeviceStrings();
    }
    return _product;
  }

  /// The serial number of the device.
  String get serial {
    if (_serial == null) {
      _updateDeviceStrings();
    }
    return _serial;
  }

  // Internal helper to retrieve the device name.
  void _updateDeviceName() {
    _name = null;
    final result = bindings.get_device_name(index);
    _name = Utf8.fromUtf8(result);
  }

  // Internal helper to retrieve the device strings.
  void _updateDeviceStrings() {
    _manufacturer = _product = _serial = null;
    final manufacturer = allocate<Uint8>(count: 256).cast<Utf8>();
    try {
      final product = allocate<Uint8>(count: 256).cast<Utf8>();
      try {
        final serial = allocate<Uint8>(count: 256).cast<Utf8>();
        try {
          final result = bindings.get_device_usb_strings(
              index, manufacturer, product, serial);
          RtlSdrException.checkError(
              result, 'Unable to get strings of device $index.');
          _manufacturer = Utf8.fromUtf8(manufacturer);
          _product = Utf8.fromUtf8(product);
          _serial = Utf8.fromUtf8(serial);
        } finally {
          free(serial);
        }
      } finally {
        free(product);
      }
    } finally {
      free(manufacturer);
    }
  }

  // Internal device handle, if opened.
  Pointer<DeviceHandle> _handle;

  /// Read-only handle of the device, if opened.
  Pointer<DeviceHandle> get handle => _handle;

  /// Tests if this device is closed.
  bool get isClosed => _handle == null;

  /// Opens the device for interaction, if it is not already open.
  void open() {
    if (isClosed) {
      if (!isValid) {
        throw RtlSdrException(0, 'Invalid device ${index}.');
      }
      final pointer = allocate<Pointer<DeviceHandle>>();
      try {
        final result = bindings.open(pointer, index);
        RtlSdrException.checkError(result, 'Unable to open device ${index}.');
        _handle = pointer.value;
      } finally {
        free(pointer);
      }
    }
  }

  /// Closes the device, if it is not already closed.
  void close() {
    if (!isClosed) {
      _closeDataStream();
      try {
        final result = bindings.close(handle);
        RtlSdrException.checkError(result, 'Unable to close device ${index}.');
      } finally {
        _handle = null;
      }
    }
  }

  // Internal stream controller of the data stream.
  StreamController<Uint8List> _streamController;

  // Internal receiver port transferring the data.
  ReceivePort _receiverPort;

  // Internal isolate reading the device data.
  Isolate _isolate;

  /// Returns a broadcast stream of the device data.
  Stream<Uint8List> get stream {
    RtlSdrException.checkOpen(this);
    _streamController ??= StreamController<Uint8List>.broadcast(
      onListen: _setupDataStream,
      onCancel: _closeDataStream,
    );
    return _streamController.stream;
  }

  // Internal helper to setup the data stream.
  void _setupDataStream() {
    RtlSdrException.checkOpen(this);
    _receiverPort = ReceivePort();
    _receiverPort.listen(_streamController.add);
    Isolate.spawn(
      readIsolate,
      ReadIsolate(handle.address, 0, 0, _receiverPort.sendPort),
    ).then((isolate) => _isolate = isolate);
  }

  // Internal helper to tear down the data stream.
  void _closeDataStream() {
    bindings.cancel_async(handle);
    _streamController?.close();
    _streamController = null;
    _receiverPort?.close();
    _receiverPort = null;
    _isolate?.kill();
    _isolate = null;
  }

  /// Get the actual frequency in Hz this device is tuned to.
  int get centerFrequency {
    RtlSdrException.checkOpen(this);
    final result = bindings.get_center_freq(handle);
    RtlSdrException.checkError(result, 'Failed to get center frequency.');
    return result;
  }

  /// Set the actual frequency in Hz the device is tuned to.
  set centerFrequency(int frequency) {
    RtlSdrException.checkOpen(this);
    final result = bindings.set_center_freq(handle, frequency);
    RtlSdrException.checkError(
        result, 'Failed to set center frequency to ${frequency}Hz.');
  }

  /// Get actual frequency correction value of the device in parts per million.
  int get frequencyCorrection {
    RtlSdrException.checkOpen(this);
    final result = bindings.get_freq_correction(handle);
    RtlSdrException.checkError(result, 'Failed to get frequency correction.');
    return result;
  }

  /// Set the frequency correction value for the device in parts per million.
  set frequencyCorrection(int ppm) {
    RtlSdrException.checkOpen(this);
    final result = bindings.set_freq_correction(handle, ppm);
    RtlSdrException.checkError(
        result, 'Failed to set frequency correction to ${ppm}ppm.');
  }

  /// Enable test mode that returns an 8 bit counter instead of the samples.
  set testMode(bool enable) {
    RtlSdrException.checkOpen(this);
    final result = bindings.set_testmode(handle, enable ? 1 : 0);
    RtlSdrException.checkError(
        result, 'Failed to ${enable ? 'enable' : 'disable'} test mode.');
  }

  /// Enable or disable the internal digital AGC of the RTL2832.
  set agcMode(bool enable) {
    RtlSdrException.checkOpen(this);
    final result = bindings.set_agc_mode(handle, enable ? 1 : 0);
    RtlSdrException.checkError(
        result, 'Failed to ${enable ? 'enable' : 'disable'} AGC mode.');
  }

  /// Get enabled state of the offset tuning.
  bool get offsetTuning {
    RtlSdrException.checkOpen(this);
    final result = bindings.get_offset_tuning(handle);
    RtlSdrException.checkError(result, 'Failed to get offset tuning.');
    return result == 1;
  }

  /// Enable or disable offset tuning for zero-IF tuners, which allows to avoid
  /// problems caused by the DC offset of the ADCs and 1/f noise.
  set offsetTuning(bool enable) {
    RtlSdrException.checkOpen(this);
    final result = bindings.set_offset_tuning(handle, enable ? 1 : 0);
    RtlSdrException.checkError(
        result, 'Failed to ${enable ? 'enable' : 'disable'} offset tuning.');
  }

  @override
  String toString() => 'RtlSdr{$index, $name}';
}
