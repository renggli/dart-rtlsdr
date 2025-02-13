import '../ffi/bindings.dart';
import '../rtlsdr.dart';
import '../utils/exception.dart';

extension FrequencyExtension on RtlSdr {
  /// Get the actual frequency in Hz this device is tuned to.
  int get centerFrequency {
    RtlSdrException.checkOpen(this);
    final result = bindings.getCenterFreq(handle);
    RtlSdrException.checkError(result, 'Failed to get center frequency');
    return result;
  }

  /// Set the actual frequency in Hz the device is tuned to.
  set centerFrequency(int frequency) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setCenterFreq(handle, frequency);
    RtlSdrException.checkError(
      result,
      'Failed to set center frequency to ${frequency}Hz',
    );
  }

  /// Get actual frequency correction value of the device in parts per million.
  int get frequencyCorrection {
    RtlSdrException.checkOpen(this);
    final result = bindings.getFreqCorrection(handle);
    RtlSdrException.checkError(result, 'Failed to get frequency correction');
    return result;
  }

  /// Set the frequency correction value for the device in parts per million.
  set frequencyCorrection(int ppm) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setFreqCorrection(handle, ppm);
    RtlSdrException.checkError(
      result,
      'Failed to set frequency correction to ${ppm}ppm',
    );
  }
}
