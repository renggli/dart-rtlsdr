library rtlsdr.device_open;

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'device.dart';
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
      throw StateError('Failed to set center freqency: ${frequency}Hz.');
    }
  }

  /// Get the actual sample rate in Hz the device is configured to.
  int get sampleRate {
    _checkOpen();
    return bindings.get_sample_rate(handle);
  }

  /// Set the actual sample rate in Hz the device is configured to.
  void set sampleRate(int frequency) {
    _checkOpen();
    final error = bindings.set_sample_rate(handle, frequency);
    if (error < 0) {
      throw StateError('Failed to set sample rate: ${frequency}Hz.');
    }
  }

  ///
  void resetBuffer() {
    _checkOpen();
    final error = bindings.reset_buffer(handle);
    if (error < 0) {
      throw StateError('Failed to reset buffers.');
    }
  }

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
