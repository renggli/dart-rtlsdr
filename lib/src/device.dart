import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'device_info.dart';
import 'ffi/bindings.dart';
import 'ffi/types.dart';
import 'utils/errors.dart';

/// RTL-SDR device.
class Device {
  /// Opens a device with the given [index].
  factory Device.fromIndex(int index) => Device.fromInfo(DeviceInfo(index));

  /// Opens a device with the given [serial] number.
  factory Device.fromSerial(String serial) {
    final index = bindings.get_index_by_serial(Utf8.toUtf8(serial));
    DeviceException.checkError(
        index, 'Unable to find device with serial "$serial".');
    return Device.fromIndex(index);
  }

  /// Opens a device from the given device [info].
  factory Device.fromInfo(DeviceInfo info) {
    final handle = allocate<Pointer<DeviceHandle>>();
    final result = bindings.open(handle, info.index);
    DeviceException.checkError(result, 'Unable to open device ${info.index}.');
    return Device(info, handle.value);
  }

  // Internal closed state..
  bool _isClosed = false;

  /// Constructor to open a device from a handle.
  Device(this.info, this.handle);

  /// The information about this device.
  final DeviceInfo info;

  /// The handle of this device.
  final Pointer<DeviceHandle> handle;

  /// Tests if the device is still open.
  bool get isClosed => _isClosed;

  /// Closes the given device, if it is open.
  void close() {
    if (!_isClosed) {
      final result = bindings.close(handle);
      _isClosed = true;
      DeviceException.checkError(result, 'Unable to close device ${info.index}.');
    }
  }

  /// Asserts that the device is still open.
  void checkOpen() {
    if (_isClosed) {
      throw StateError('Device has been closed.');
    }
  }

  /// Get the actual frequency in Hz this device is tuned to.
  int get centerFrequency {
    checkOpen();
    final result = bindings.get_center_freq(handle);
    if (result <= 0) {
      throw StateError('Failed to get center frequency.');
    }
    return result;
  }

  /// Set the actual frequency in Hz the device is tuned to.
  set centerFrequency(int frequency) {
    checkOpen();
    final result = bindings.set_center_freq(handle, frequency);
    if (result < 0) {
      throw StateError('Failed to set center frequency to ${frequency}Hz.');
    }
  }

  /// Get actual frequency correction value of the device in parts per million.
  int get frequencyCorrection {
    checkOpen();
    final result = bindings.get_freq_correction(handle);
    if (result < 0) {
      throw StateError('Failed to get frequency correction.');
    }
    return result;
  }

  /// Set the frequency correction value for the device in parts per million.
  set frequencyCorrection(int ppm) {
    checkOpen();
    final result = bindings.set_freq_correction(handle, ppm);
    if (result < 0) {
      throw StateError('Failed to set frequency correction to ${ppm}ppm.');
    }
  }

  /// Enable test mode that returns an 8 bit counter instead of the samples.
  set testMode(bool enable) {
    checkOpen();
    final result = bindings.set_testmode(handle, enable ? 1 : 0);
    if (result < 0) {
      throw StateError('Failed to ${enable ? 'enable' : 'disable'} test mode.');
    }
  }

  /// Enable or disable the internal digital AGC of the RTL2832.
  set agcMode(bool enable) {
    checkOpen();
    final result = bindings.set_agc_mode(handle, enable ? 1 : 0);
    if (result != 0) {
      throw StateError('Failed to ${enable ? 'enable' : 'disable'} AGC mode.');
    }
  }

  /// Get enabled state of the offset tuning.
  bool get offsetTuning {
    checkOpen();
    final result = bindings.get_offset_tuning(handle);
    if (result < 0) {
      throw StateError('Failed to get offset tuning.');
    }
    return result == 1;
  }

  /// Enable or disable offset tuning for zero-IF tuners, which allows to avoid
  /// problems caused by the DC offset of the ADCs and 1/f noise.
  set offsetTuning(bool enable) {
    checkOpen();
    final result = bindings.set_offset_tuning(handle, enable ? 1 : 0);
    if (result < 0) {
      throw StateError(
          'Failed to ${enable ? 'enable' : 'disable'} offset tuning.');
    }
  }

  @override
  String toString() => 'Device{${info.name}}';
}
