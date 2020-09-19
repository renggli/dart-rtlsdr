import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../device.dart';
import '../ffi/bindings.dart';
import '../utils/errors.dart';

extension ReadSyncDeviceExtension on Device {
  /// Reset the internal buffer of the device.
  void resetBuffer() {
    DeviceException.checkOpen(this);
    final result = bindings.reset_buffer(handle);
    DeviceException.checkError(result, 'Failed to reset buffers.');
  }

  /// Synchronously read [count] into the pre-allocated [buffer].
  Uint8List readBytesSync(Pointer<Uint8> buffer, int count) {
    DeviceException.checkOpen(this);
    final size = allocate<IntPtr>();
    try {
      size.value = 0;
      final result = bindings.read_sync(handle, buffer, count, size);
      DeviceException.checkError(result, 'Failed to read $count bytes.');
      return buffer.asTypedList(size.value);
    } finally {
      free(size);
    }
  }
}
