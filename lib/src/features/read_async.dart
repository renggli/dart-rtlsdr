import 'dart:ffi';
import 'dart:typed_data';

import '../device.dart';
import '../ffi/bindings.dart';
import '../ffi/signatures.dart';
import '../utils/errors.dart';

extension ReadAsyncDeviceExtension on Device {
  // Asynchronously executes the callback [onData] with a buffer of the
  // consumed data.
  void readAsync(
    bool Function(Uint8List data) onData, {
    int bufferCount = 0,
    int bufferSize = 0,
  }) {
    checkOpen();
    final context = AsyncContext(asyncKey++, this, onData);
    asyncContexts[context.key] = context;
    try {
      final result = bindings.read_async(
          handle, asyncCallbackPointer, context.key, bufferCount, bufferSize);
      if (context.thrownError != null) {
        throw context.thrownError;
      }
      DeviceException.checkError(result, 'Failed to read asynchronously');
    } finally {
      asyncContexts.remove(context.key);
    }
  }
}

typedef AsyncCallback = bool Function(Uint8List data);

class AsyncContext {
  final int key;
  final Device device;
  final AsyncCallback callback;
  Error thrownError;
  StackTrace stackTrace;

  AsyncContext(this.key, this.device, this.callback);

  void close() {
    asyncContexts.remove(key);
    bindings.cancel_async(device.handle);
  }
}

int asyncKey = 0;
final Map<int, AsyncContext> asyncContexts = {};

void asyncCallback(Pointer<Uint8> buffer, int length, int key) {
  final context = asyncContexts[key];
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

final asyncCallbackPointer =
    Pointer.fromFunction<rtlsdr_read_async_cb_t>(asyncCallback);
