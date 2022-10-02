import 'dart:ffi';
import 'dart:isolate';

import '../ffi/bindings.dart';
import '../ffi/types.dart';
import 'exception.dart';

class ReadIsolate {
  ReadIsolate(this.address, this.bufferCount, this.bufferSize, this.sendPort);

  final int address;
  final int bufferCount;
  final int bufferSize;
  final SendPort sendPort;
}

ReadIsolate? _arguments;

void readIsolate(ReadIsolate arguments) {
  _arguments = arguments;
  final handle = Pointer<DeviceHandle>.fromAddress(arguments.address);
  final resetBuffer = bindings.resetBuffer(handle);
  RtlSdrException.checkError(resetBuffer, 'Failed to reset buffers');
  final readAsync = bindings.readAsync(handle, asyncCallbackPointer, nullptr,
      arguments.bufferCount, arguments.bufferSize);
  RtlSdrException.checkError(readAsync, 'Failed to read asynchronously');
}

final asyncCallbackPointer =
    Pointer.fromFunction<ReadAsyncCallback>(asyncCallback);

void asyncCallback(Pointer<Uint8> buffer, int length, Pointer<Void> context) =>
    _arguments?.sendPort.send(buffer.asTypedList(length));
