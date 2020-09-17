import '../device.dart';
import '../ffi/bindings.dart';

extension SamplingDeviceExtension on Device {
  /// Get the actual sample rate in Hz the device is configured to.
  int get sampleRate {
    checkOpen();
    final result = bindings.get_sample_rate(handle);
    if (result <= 0) {
      throw StateError('Failed to get sample rate.');
    }
    return result;
  }

  /// Set the actual sample rate in Hz the device is configured to.
  set sampleRate(int rate) {
    checkOpen();
    final result = bindings.set_sample_rate(handle, rate);
    if (result < 0) {
      throw StateError('Failed to set sample rate to ${rate}Hz.');
    }
  }

  /// Get the actual sample rate in Hz the device is configured to.
  DirectSamplingMode get directSamplingMode {
    checkOpen();
    final index = bindings.get_direct_sampling(handle);
    return 0 <= index && index < DirectSamplingMode.values.length
        ? DirectSamplingMode.values[index]
        : throw StateError('Failed to get direct sampling mode.');
  }

  /// Set the actual sample rate in Hz the device is configured to.
  set directSamplingMode(DirectSamplingMode mode) {
    checkOpen();
    final result = bindings.set_direct_sampling(
        handle, DirectSamplingMode.values.indexOf(mode));
    if (result != 0) {
      throw StateError('Failed to set direct sampling mode to ${mode}.');
    }
  }
}

enum DirectSamplingMode {
  disabled, // 0
  iadc, // 1
  qadc, // 2
}
