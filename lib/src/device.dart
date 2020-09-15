import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'device_open.dart';
import 'ffi/bindings.dart';
import 'ffi/types.dart';
import 'utils/device_strings.dart';

class Device {
  Device(this.bindings, this.index);

  /// Index of this device.
  final int index;

  /// Library handling this device.
  final Bindings bindings;

  /// Name of the device.
  String get name => Utf8.fromUtf8(bindings.get_device_name(index));

  /// Strings describing the device.
  DeviceStrings get deviceStrings {
    final manufact = allocate<Uint8>(count: 256).cast<Utf8>();
    final product = allocate<Uint8>(count: 256).cast<Utf8>();
    final serial = allocate<Uint8>(count: 256).cast<Utf8>();
    try {
      final error =
          bindings.get_device_usb_strings(index, manufact, product, serial);
      if (error != 0) {
        return throw ArgumentError('Unable to get device strings: $error.');
      }
      return DeviceStrings(Utf8.fromUtf8(manufact), Utf8.fromUtf8(product),
          Utf8.fromUtf8(serial));
    } finally {
      free(manufact);
      free(product);
      free(serial);
    }
  }

  /// Open the given device.
  DeviceOpen open() {
    final handle = allocate<Pointer<DeviceHandle>>();
    final error = bindings.open(handle, index);
    if (error != 0) {
      throw StateError('Unable to open device $index: $error');
    }
    return DeviceOpen(bindings, index, handle.value);
  }

  @override
  String toString() => '$name';
}
