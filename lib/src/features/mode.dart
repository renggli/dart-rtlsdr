import '../ffi/bindings.dart';
import '../rtlsdr.dart';
import '../utils/exception.dart';

extension ModeExtension on RtlSdr {
  /// Enable test mode that returns an 8 bit counter instead of the samples.
  set testMode(bool enable) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setTestmode(handle, enable ? 1 : 0);
    RtlSdrException.checkError(
        result, 'Failed to ${enable ? 'enable' : 'disable'} test mode');
  }

  /// Enable or disable the internal digital AGC of the RTL2832.
  set agcMode(bool enable) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setAgcMode(handle, enable ? 1 : 0);
    RtlSdrException.checkError(
        result, 'Failed to ${enable ? 'enable' : 'disable'} AGC mode');
  }

  /// Get enabled state of the offset tuning.
  bool get offsetTuning {
    RtlSdrException.checkOpen(this);
    final result = bindings.getOffsetTuning(handle);
    RtlSdrException.checkError(result, 'Failed to get offset tuning');
    return result == 1;
  }

  /// Enable or disable offset tuning for zero-IF tuners, which allows to avoid
  /// problems caused by the DC offset of the ADCs and 1/f noise.
  set offsetTuning(bool enable) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setOffsetTuning(handle, enable ? 1 : 0);
    RtlSdrException.checkError(
        result, 'Failed to ${enable ? 'enable' : 'disable'} offset tuning');
  }
}
