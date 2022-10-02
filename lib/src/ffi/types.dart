import 'dart:ffi';

// Handle of the RTL device.
class DeviceHandle extends Opaque {}

// Callback for async processing.
typedef ReadAsyncCallback = Void Function(
    Pointer<Uint8> buffer, Uint32 length, Pointer<Void> context);
