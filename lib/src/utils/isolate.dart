import 'dart:ffi';
import 'dart:isolate';

import '../ffi/bindings.dart';
import '../ffi/signatures.dart';
import '../ffi/types.dart';
import 'errors.dart';

class ReadIsolate {
  final int address;
  final int bufferCount;
  final int bufferSize;
  final SendPort sendPort;

  ReadIsolate(this.address, this.bufferCount, this.bufferSize, this.sendPort);
}

ReadIsolate _arguments;

void readIsolate(ReadIsolate arguments) {
  _arguments = arguments;
  final handle = Pointer<DeviceHandle>.fromAddress(arguments.address);
  final resetBuffer = bindings.reset_buffer(handle);
  RtlSdrException.checkError(resetBuffer, 'Failed to reset buffers.');
  final readAsync = bindings.read_async(handle, asyncCallbackPointer, 0,
      arguments.bufferCount, arguments.bufferSize);
  RtlSdrException.checkError(readAsync, 'Failed to read asynchronously');
}

final asyncCallbackPointer =
    Pointer.fromFunction<rtlsdr_read_async_cb_t>(asyncCallback);

void asyncCallback(Pointer<Uint8> buffer, int length, int key) =>
    _arguments.sendPort.send(buffer.asTypedList(length));
