import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import '../device.dart';
import '../ffi/bindings.dart';
import '../ffi/signatures.dart';
import '../ffi/types.dart';
import '../utils/errors.dart';

StreamController<Uint8List> _controller;
ReceivePort _receiver;
Isolate _isolate;

class _StreamArguments {
  final int handle;
  final SendPort sendPort;

  _StreamArguments(this.handle, this.sendPort);
}

extension ReadStreamDeviceExtension on Device {
  Stream<Uint8List> get stream {
    _controller ??= StreamController<Uint8List>.broadcast(
      onListen: _onListen,
      onCancel: _onCancel,
      sync: true,
    );
    return _controller.stream;
  }

  void _onListen() {
    DeviceException.checkOpen(this);
    _receiver = ReceivePort();
    _receiver.listen((data) => _controller.add(data));
    Isolate.spawn(
      _readLoop,
      _StreamArguments(handle.address, _receiver.sendPort),
      debugName: info.name,
    ).then((isolate) => _isolate = isolate);
  }

  Future<void> _onCancel() async {
    _receiver?.close();
    _receiver = null;
    _isolate?.kill();
    _isolate = null;
  }
}

// The following data and code is local to the data reading isolate.

_StreamArguments _arguments;

void _readLoop(_StreamArguments arguments) {
  _arguments = arguments;
  final handle = Pointer<DeviceHandle>.fromAddress(arguments.handle);

  final resetBuffer = bindings.reset_buffer(handle);
  DeviceException.checkError(resetBuffer, 'Failed to reset buffers.');

  final readAsync = bindings.read_async(handle, asyncCallbackPointer, 0, 0, 0);
  DeviceException.checkError(readAsync, 'Failed to read asynchronously');
}

final asyncCallbackPointer =
    Pointer.fromFunction<rtlsdr_read_async_cb_t>(asyncCallback);

void asyncCallback(Pointer<Uint8> buffer, int length, int key) =>
    _arguments.sendPort.send(buffer.asTypedList(length));
