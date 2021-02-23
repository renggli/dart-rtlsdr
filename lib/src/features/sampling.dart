import '../ffi/bindings.dart';
import '../rtlsdr.dart';
import '../utils/errors.dart';

extension SamplingExtension on RtlSdr {
  /// Gets the actual sample rate in Hz the device is configured to.
  int get sampleRate {
    RtlSdrException.checkOpen(this);
    final result = bindings.getSampleRate(handle);
    RtlSdrException.checkError(result, 'Failed to get sample rate.');
    return result;
  }

  /// Sets the actual sample rate in Hz the device is configured to.
  set sampleRate(int rate) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setSampleRate(handle, rate);
    RtlSdrException.checkError(
        result, 'Failed to set sample rate to ${rate}Hz.');
  }

  /// Gets the actual sample rate in Hz the device is configured to.
  DirectSamplingMode get directSamplingMode {
    RtlSdrException.checkOpen(this);
    final result = bindings.getDirectSampling(handle);
    return 0 <= result && result < DirectSamplingMode.values.length
        ? DirectSamplingMode.values[result]
        : throw RtlSdrException(result, 'Failed to get direct sampling mode.');
  }

  /// Sets the direct sampling mode.
  set directSamplingMode(DirectSamplingMode mode) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setDirectSampling(
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
