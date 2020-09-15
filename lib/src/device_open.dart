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
    return bindings.get_center_freq(handle);
  }

  /// Set the actual frequency in Hz the device is tuned to.
  void set centerFrequency(int frequency) {
    _checkOpen();
    final error = bindings.set_center_freq(handle, frequency);
    if (error < 0) {
      throw StateError('Failed to set center frequency: ${frequency}Hz');
    }
  }

  /// Get actual frequency correction value of the device in parts per million.
  int get frequencyCorrection {
    _checkOpen();
    return bindings.get_freq_correction(handle);
  }

  /// Set the frequency correction value for the device in parts per million.
  void set frequencyCorrection(int ppm) {
    _checkOpen();
    final error = bindings.set_freq_correction(handle, ppm);
    if (error < 0) {
      throw StateError('Failed to set frequency correction: ${ppm}ppm');
    }
  }

  /// Set the gain mode for the device.
  void set tunerGainMode(TunerGainMode mode) {
    _checkOpen();
    final error = bindings.set_tuner_gain_mode(
        handle, TunerGainMode.automatic == mode ? 0 : 1);
    if (error < 0) {
      throw StateError('Failed to set manual tuner gain mode: ${mode}');
    }
  }

  /// Get a list of all gains supported by the tuner in 10th of a dB.
  List<int> get tunerGains {
    _checkOpen();
    final count = bindings.get_tuner_gains(handle, nullptr);
    if (count > 0) {
      final gains = allocate<Int32>(count: count);
      try {
        final error = bindings.get_tuner_gains(handle, gains.cast<IntPtr>());
        if (error > 0) {
          return gains.asTypedList(error).toList(growable: false);
        }
      } finally {
        free(gains);
      }
    }
    throw StateError('Failed to get tuner gains.');
  }

  /// Get actual gain the device is configured to in 10th of a dB.
  int get tunerGain {
    _checkOpen();
    return bindings.get_tuner_gain(handle);
  }

  /// Set the gain for the device in 10th of a dB.
  /// Manual gain mode must be enabled for this to work.
  void set tunerGain(int gain) {
    _checkOpen();
    final error = bindings.set_tuner_gain(handle, gain);
    if (error < 0) {
      throw StateError('Failed to set tuner gain: ${gain}');
    }
  }

  /// Get the actual sample rate in Hz the device is configured to.
  int get sampleRate {
    _checkOpen();
    return bindings.get_sample_rate(handle);
  }

  /// Set the actual sample rate in Hz the device is configured to.
  void set sampleRate(int rate) {
    _checkOpen();
    final error = bindings.set_sample_rate(handle, rate);
    if (error < 0) {
      throw StateError('Failed to set sample rate: ${rate}Hz');
    }
  }

  /// Reset the internal buffer of the device.
  void resetBuffer() {
    _checkOpen();
    final error = bindings.reset_buffer(handle);
    if (error < 0) {
      throw StateError('Failed to reset buffers.');
    }
  }

  /// Synchronously read [count] into the pre-allocated [buffer].
  Uint8List readSync(Pointer<Uint8> buffer, int count) {
    _checkOpen();
    final size = allocate<IntPtr>();
    try {
      size.value = 0;
      final error = bindings.read_sync(handle, buffer, count, size);
      if (error < 0) {
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
      final error = bindings.read_async(
          handle, _asyncCallbackPointer, context.key, bufferCount, bufferSize);
      if (context.thrownError != null) {
        throw context.thrownError;
      } else if (error < 0) {
        throw StateError('Failed to read asynchronously: $error.');
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
  _checkOpen() {
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
  } catch (error, stackTrace) {
    context.thrownError = error;
    context.stackTrace = stackTrace;
    context.close();
  }
}

final _asyncCallbackPointer =
    Pointer.fromFunction<rtlsdr_read_async_cb_t>(_asyncCallback);
