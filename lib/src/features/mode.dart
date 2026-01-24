import '../ffi/bindings.dart';
import '../rtlsdr.dart';
import '../utils/exception.dart';

extension ModeExtension on RtlSdr {
  /// Enable test mode that returns an 8 bit counter instead of the samples.
  ///
  /// Example:
  /// ```dart
  /// device.testMode = true;
  /// ```
  set testMode(bool enable) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setTestmode(handle, enable ? 1 : 0);
    RtlSdrException.checkError(
      result,
      'Failed to ${enable ? 'enable' : 'disable'} test mode',
    );
  }

  /// Enable or disable the internal digital AGC of the RTL2832.
  ///
  /// Example:
  /// ```dart
  /// device.agcMode = true;
  /// ```
  set agcMode(bool enable) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setAgcMode(handle, enable ? 1 : 0);
    RtlSdrException.checkError(
      result,
      'Failed to ${enable ? 'enable' : 'disable'} AGC mode',
    );
  }

  /// Get enabled state of the offset tuning.
  ///
  /// Example:
  /// ```dart
  /// print('Offset tuning: ${device.offsetTuning}');
  /// ```
  bool get offsetTuning {
    RtlSdrException.checkOpen(this);
    final result = bindings.getOffsetTuning(handle);
    RtlSdrException.checkError(result, 'Failed to get offset tuning');
    return result == 1;
  }

  /// Enable or disable offset tuning for zero-IF tuners.
  ///
  /// This allows to avoid problems caused by the DC offset of the ADCs and 1/f
  /// noise.
  ///
  /// Example:
  /// ```dart
  /// device.offsetTuning = true;
  /// ```
  set offsetTuning(bool enable) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setOffsetTuning(handle, enable ? 1 : 0);
    RtlSdrException.checkError(
      result,
      'Failed to ${enable ? 'enable' : 'disable'} offset tuning',
    );
  }
}
