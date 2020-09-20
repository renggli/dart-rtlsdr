import '../ffi/bindings.dart';
import '../rtlsdr.dart';
import '../utils/errors.dart';

extension SamplingExtension on RtlSdr {
  /// Get the actual sample rate in Hz the device is configured to.
  int get sampleRate {
    RtlSdrException.checkOpen(this);
    final result = bindings.get_sample_rate(handle);
    RtlSdrException.checkError(result, 'Failed to get sample rate.');
    return result;
  }

  /// Set the actual sample rate in Hz the device is configured to.
  set sampleRate(int rate) {
    RtlSdrException.checkOpen(this);
    final result = bindings.set_sample_rate(handle, rate);
    RtlSdrException.checkError(
        result, 'Failed to set sample rate to ${rate}Hz.');
  }

  /// Get the actual sample rate in Hz the device is configured to.
  DirectSamplingMode get directSamplingMode {
    RtlSdrException.checkOpen(this);
    final result = bindings.get_direct_sampling(handle);
    return 0 <= result && result < DirectSamplingMode.values.length
        ? DirectSamplingMode.values[result]
        : throw RtlSdrException(result, 'Failed to get direct sampling mode.');
  }

  /// Set the actual sample rate in Hz the device is configured to.
  set directSamplingMode(DirectSamplingMode mode) {
    RtlSdrException.checkOpen(this);
    final result = bindings.set_direct_sampling(
        handle, DirectSamplingMode.values.indexOf(mode));
    RtlSdrException.checkError(
        result, 'Failed to set direct sampling mode to ${mode}.');
  }
}

enum DirectSamplingMode {
  disabled, // 0
  iadc, // 1
  qadc, // 2
}
