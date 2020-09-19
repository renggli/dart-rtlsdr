import '../device.dart';
import '../ffi/bindings.dart';
import '../utils/errors.dart';

extension SamplingDeviceExtension on Device {
  /// Get the actual sample rate in Hz the device is configured to.
  int get sampleRate {
    DeviceException.checkOpen(this);
    final result = bindings.get_sample_rate(handle);
    DeviceException.checkError(result, 'Failed to get sample rate.');
    return result;
  }

  /// Set the actual sample rate in Hz the device is configured to.
  set sampleRate(int rate) {
    DeviceException.checkOpen(this);
    final result = bindings.set_sample_rate(handle, rate);
    DeviceException.checkError(
        result, 'Failed to set sample rate to ${rate}Hz.');
  }

  /// Get the actual sample rate in Hz the device is configured to.
  DirectSamplingMode get directSamplingMode {
    DeviceException.checkOpen(this);
    final result = bindings.get_direct_sampling(handle);
    return 0 <= result && result < DirectSamplingMode.values.length
        ? DirectSamplingMode.values[result]
        : throw DeviceException(result, 'Failed to get direct sampling mode.');
  }

  /// Set the actual sample rate in Hz the device is configured to.
  set directSamplingMode(DirectSamplingMode mode) {
    DeviceException.checkOpen(this);
    final result = bindings.set_direct_sampling(
        handle, DirectSamplingMode.values.indexOf(mode));
    DeviceException.checkError(
        result, 'Failed to set direct sampling mode to ${mode}.');
  }
}

enum DirectSamplingMode {
  disabled, // 0
  iadc, // 1
  qadc, // 2
}
