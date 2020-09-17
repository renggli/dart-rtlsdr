import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../device.dart';
import '../ffi/bindings.dart';

extension TunerDeviceExtension on Device {
  /// Get the tuner type.
  TunerType get tunerType {
    checkOpen();
    final result = bindings.get_tuner_type(handle);
    return 0 <= result && result < TunerType.values.length
        ? TunerType.values[result]
        : throw StateError('Failed to get tuner type.');
  }

  /// Set the gain mode for the device.
  set tunerGainMode(TunerGainMode mode) {
    checkOpen();
    final result = bindings.set_tuner_gain_mode(
        handle, TunerGainMode.values.indexOf(mode));
    if (result < 0) {
      throw StateError('Failed to set manual tuner gain mode to ${mode}.');
    }
  }

  /// Get a list of all gains supported by the tuner in dB.
  List<double> get tunerGains {
    checkOpen();
    final count = bindings.get_tuner_gains(handle, nullptr);
    if (count > 0) {
      final gains = allocate<Int32>(count: count);
      try {
        final error = bindings.get_tuner_gains(handle, gains.cast<IntPtr>());
        if (error > 0) {
          return gains
              .asTypedList(error)
              .map((value) => value / 10.0)
              .toList(growable: false);
        }
      } finally {
        free(gains);
      }
    }
    throw StateError('Failed to get tuner gains.');
  }

  /// Get actual gain the device is configured to in dB.
  double get tunerGain {
    checkOpen();
    final result = bindings.get_tuner_gain(handle);
    if (result < 0) {
      throw StateError('Failed to read tuner gain.');
    }
    return result / 10.0;
  }

  /// Set the gain for the device in dB.
  /// Manual gain mode must be enabled for this to work.
  set tunerGain(double gain) {
    checkOpen();
    final result = bindings.set_tuner_gain(handle, (10.0 * gain).round());
    if (result < 0) {
      throw StateError('Failed to set tuner gain to ${gain}dB.');
    }
  }

  /// Set the bandwidth for the device in Hz, 0 means automatic selection.
  set tunerBandwidth(int bandwidth) {
    checkOpen();
    final result = bindings.set_tuner_bandwidth(handle, bandwidth);
    if (result < 0) {
      throw StateError('Failed to set tuner bandwidth to ${bandwidth}Hz.');
    }
  }

  /// Set the intermediate frequency gain for the device.
  ///
  /// - [stage] intermediate frequency gain stage number (1 to 6 for E4000)
  /// - [gain] in dB, -30 means -3.0 dB.
  void tunerIfGain(int stage, double gain) {
    checkOpen();
    final result =
        bindings.set_tuner_if_gain(handle, stage, (10.0 * gain).round());
    if (result < 0) {
      throw StateError('Failed to set intermediate frequency gain '
          'at ${stage} to ${gain}dB.');
    }
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
