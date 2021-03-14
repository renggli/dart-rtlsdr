import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../ffi/bindings.dart';
import '../rtlsdr.dart';
import '../utils/errors.dart';

extension TunerExtension on RtlSdr {
  /// Get the tuner type.
  TunerType get tunerType {
    RtlSdrException.checkOpen(this);
    final result = bindings.getTunerType(handle);
    return 0 <= result && result < TunerType.values.length
        ? TunerType.values[result]
        : throw RtlSdrException(result, 'Failed to get tuner type.');
  }

  /// Set the gain mode for the device.
  set tunerGainMode(TunerGainMode mode) {
    RtlSdrException.checkOpen(this);
    final result =
        bindings.setTunerGainMode(handle, TunerGainMode.values.indexOf(mode));
    RtlSdrException.checkError(
        result, 'Failed to set manual tuner gain mode to $mode.');
  }

  /// Get a list of all gains supported by the tuner in dB.
  List<double> get tunerGains {
    RtlSdrException.checkOpen(this);
    final count = bindings.getTunerGains(handle, nullptr);
    if (count > 0) {
      final gains = malloc<Int32>(count);
      try {
        final result = bindings.getTunerGains(handle, gains.cast<IntPtr>());
        RtlSdrException.checkError(result, 'Failed to get tuner gains.');
        return gains
            .asTypedList(result)
            .map((value) => value / 10.0)
            .toList(growable: false);
      } finally {
        malloc.free(gains);
      }
    }
    throw RtlSdrException(count, 'Failed to get tuner gain count.');
  }

  /// Get actual gain the device is configured to in dB.
  double get tunerGain {
    RtlSdrException.checkOpen(this);
    final result = bindings.getTunerGain(handle);
    RtlSdrException.checkError(result, 'Failed to read tuner gain.');
    return result / 10.0;
  }

  /// Set the gain for the device in dB.
  /// Manual gain mode must be enabled for this to work.
  set tunerGain(double gain) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setTunerGain(handle, (10.0 * gain).round());
    RtlSdrException.checkError(
        result, 'Failed to set tuner gain to ${gain}dB.');
  }

  /// Set the bandwidth for the device in Hz, 0 means automatic selection.
  set tunerBandwidth(int bandwidth) {
    RtlSdrException.checkOpen(this);
    final result = bindings.setTunerBandwidth(handle, bandwidth);
    RtlSdrException.checkError(
        result, 'Failed to set tuner bandwidth to ${bandwidth}Hz.');
  }

  /// Set the intermediate frequency gain for the device.
  ///
  /// - [stage] intermediate frequency gain stage number (1 to 6 for E4000)
  /// - [gain] in dB, -30 means -3.0 dB.
  void tunerIntermediateFrequencyGain(int stage, double gain) {
    RtlSdrException.checkOpen(this);
    final result =
        bindings.setTunerIfGain(handle, stage, (10.0 * gain).round());
    RtlSdrException.checkError(
        result,
        'Failed to set intermediate frequency '
        'gain at $stage to ${gain}dB.');
  }
}

enum TunerGainMode {
  automatic, // 0
  manual, // 1
}

enum TunerType {
  unknown, // 0
  e4000, // 1
  fc0012, // 2
  fc0013, // 3
  fc2580, // 4
  r820t, // 5
  r828d, // 6
}
