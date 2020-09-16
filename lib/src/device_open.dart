import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'device.dart';
import 'enums.dart';
import 'ffi/bindings.dart';
import 'ffi/signatures.dart';
import 'ffi/types.dart';

class DeviceOpen extends Device {
  DeviceOpen(Bindings bindings, int index, this.handle)
      : super(bindings, index);

  final Pointer<DeviceHandle> handle;

  bool _isClosed = false;

  /// Get the actual frequency in Hz this device is tuned to.
  int get centerFrequency {
    _checkOpen();
    final result = bindings.get_center_freq(handle);
    if (result <= 0) {
      throw StateError('Failed to get center frequency.');
    }
    return result;
  }

  /// Set the actual frequency in Hz the device is tuned to.
  set centerFrequency(int frequency) {
    _checkOpen();
    final result = bindings.set_center_freq(handle, frequency);
    if (result < 0) {
      throw StateError('Failed to set center frequency to ${frequency}Hz.');
    }
  }

  /// Get actual frequency correction value of the device in parts per million.
  int get frequencyCorrection {
    _checkOpen();
    final result = bindings.get_freq_correction(handle);
    if (result < 0) {
      throw StateError('Failed to get frequency correction.');
    }
    return result;
  }

  /// Set the frequency correction value for the device in parts per million.
  set frequencyCorrection(int ppm) {
    _checkOpen();
    final result = bindings.set_freq_correction(handle, ppm);
    if (result < 0) {
      throw StateError('Failed to set frequency correction to ${ppm}ppm.');
    }
  }

  /// Enable test mode that returns an 8 bit counter instead of the samples.
  set testMode(bool enable) {
    _checkOpen();
    final result = bindings.set_testmode(handle, enable ? 1 : 0);
    if (result < 0) {
      throw StateError('Failed to ${enable ? 'enable' : 'disable'} test mode.');
    }
  }

  /// Get the tuner type.
  TunerType get tunerType {
    _checkOpen();
    final result = bindings.get_tuner_type(handle);
    return 0 <= result && result < TunerType.values.length
        ? TunerType.values[result]
        : throw StateError('Failed to get tuner type.');
  }

  /// Set the gain mode for the device.
  set tunerGainMode(TunerGainMode mode) {
    _checkOpen();
    final result = bindings.set_tuner_gain_mode(
        handle, TunerGainMode.values.indexOf(mode));
    if (result < 0) {
      throw StateError('Failed to set manual tuner gain mode to ${mode}.');
    }
  }

  /// Get a list of all gains supported by the tuner in dB.
  List<double> get tunerGains {
    _checkOpen();
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
    _checkOpen();
    final result = bindings.get_tuner_gain(handle);
    if (result < 0) {
      throw StateError('Failed to read tuner gain.');
    }
    return result / 10.0;
  }

  /// Set the gain for the device in dB.
  /// Manual gain mode must be enabled for this to work.
  set tunerGain(double gain) {
    _checkOpen();
    final result = bindings.set_tuner_gain(handle, (10.0 * gain).round());
    if (result < 0) {
      throw StateError('Failed to set tuner gain to ${gain}dB.');
    }
  }

  /// Set the bandwidth for the device in Hz, 0 means automatic selection.
  set tunerBandwidth(int bandwidth) {
    _checkOpen();
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
    _checkOpen();
    final result =
        bindings.set_tuner_if_gain(handle, stage, (10.0 * gain).round());
    if (result < 0) {
      throw StateError('Failed to set intermediate frequency gain '
          'at ${stage} to ${gain}dB.');
    }
  }

  /// Get the actual sample rate in Hz the device is configured to.
  int get sampleRate {
    _checkOpen();
    final result = bindings.get_sample_rate(handle);
    if (result <= 0) {
      throw StateError('Failed to get sample rate.');
    }
    return result;
  }

  /// Set the actual sample rate in Hz the device is configured to.
  set sampleRate(int rate) {
    _checkOpen();
    final result = bindings.set_sample_rate(handle, rate);
    if (result < 0) {
      throw StateError('Failed to set sample rate to ${rate}Hz.');
    }
  }

  /// Get the actual sample rate in Hz the device is configured to.
  DirectSamplingMode get directSamplingMode {
    _checkOpen();
    final index = bindings.get_direct_sampling(handle);
    return 0 <= index && index < DirectSamplingMode.values.length
        ? DirectSamplingMode.values[index]
        : throw StateError('Failed to get direct sampling mode.');
  }

  /// Set the actual sample rate in Hz the device is configured to.
  set directSamplingMode(DirectSamplingMode mode) {
    _checkOpen();
    final result = bindings.set_direct_sampling(
        handle, DirectSamplingMode.values.indexOf(mode));
    if (result != 0) {
      throw StateError('Failed to set direct sampling mode to ${mode}.');
    }
  }

  /// Enable or disable the internal digital AGC of the RTL2832.
  set agcMode(bool enable) {
    _checkOpen();
    final result = bindings.set_agc_mode(handle, enable ? 1 : 0);
    if (result != 0) {
      throw StateError('Failed to ${enable ? 'enable' : 'disable'} AGC mode.');
    }
  }

  /// Get enabled state of the offset tuning.
  bool get offsetTuning {
    _checkOpen();
    final result = bindings.get_offset_tuning(handle);
    if (result < 0) {
      throw StateError('Failed to get offset tuning.');
    }
    return result == 1;
  }

  /// Enable or disable offset tuning for zero-IF tuners, which allows to avoid
  /// problems caused by the DC offset of the ADCs and 1/f noise.
  set offsetTuning(bool enable) {
    _checkOpen();
    final result = bindings.set_offset_tuning(handle, enable ? 1 : 0);
    if (result < 0) {
      throw StateError(
          'Failed to ${enable ? 'enable' : 'disable'} offset tuning.');
    }
  }

  /// Reset the internal buffer of the device.
  void resetBuffer() {
    _checkOpen();
    final result = bindings.reset_buffer(handle);
    if (result < 0) {
      throw StateError('Failed to reset buffers.');
    }
  }

  /// Synchronously read [count] into the pre-allocated [buffer].
  Uint8List readSync(Pointer<Uint8> buffer, int count) {
    _checkOpen();
    final size = allocate<IntPtr>();
    try {
      size.value = 0;
      final result = bindings.read_sync(handle, buffer, count, size);
      if (result < 0) {
        throw StateError('Failed to read synchronous.');
      }
      return buffer.asTypedList(size.value);
    } finally {
      free(size);
    }
  }

  // Asynchronously executes the callback [onData] with a buffer of the
  // consumed data.
  void readAsync(
    bool Function(Uint8List data) onData, {
    int bufferCount = 0,
    int bufferSize = 0,
  }) {
    _checkOpen();
    final context = _AsyncContext(_asyncKey++, this, onData);
    _asyncContexts[context.key] = context;
    try {
      final result = bindings.read_async(
          handle, _asyncCallbackPointer, context.key, bufferCount, bufferSize);
      if (context.thrownError != null) {
        throw context.thrownError;
      } else if (result < 0) {
        throw StateError('Failed to read asynchronously: $result.');
      }
    } finally {
      _asyncContexts.remove(context.key);
    }
  }

  /// Return true, if the device has been closed.
  bool get isClosed => _isClosed;

  /// Closes the given device, if it is open.
  void close() {
    if (!isClosed) {
      bindings.close(handle);
      _isClosed = true;
    }
  }

  /// Asserts that the device is still open.
  void _checkOpen() {
    if (_isClosed) {
      throw StateError('Device has been closed.');
    }
  }
}

typedef AsyncCallback = bool Function(Uint8List data);

class _AsyncContext {
  final int key;
  final DeviceOpen device;
  final AsyncCallback callback;
  Error thrownError;
  StackTrace stackTrace;

  _AsyncContext(this.key, this.device, this.callback);

  void close() {
    _asyncContexts.remove(key);
    device.bindings.cancel_async(device.handle);
  }
}

int _asyncKey = 0;
final Map<int, _AsyncContext> _asyncContexts = {};

void _asyncCallback(Pointer<Uint8> buffer, int length, int key) {
  final context = _asyncContexts[key];
  if (context == null) {
    throw StateError('Invalid async context: $key');
  }
  try {
    if (!context.callback(buffer.asTypedList(length))) {
      context.close();
    }
    // ignore: avoid_catches_without_on_clauses
  } catch (error, stackTrace) {
    context.thrownError = error;
    context.stackTrace = stackTrace;
    context.close();
  }
}

final _asyncCallbackPointer =
    Pointer.fromFunction<rtlsdr_read_async_cb_t>(_asyncCallback);
