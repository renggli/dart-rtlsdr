library rtlsdr.device;

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:rtlsdr/src/device_open.dart';

import 'ffi/bindings.dart';
import 'ffi/types.dart';

abstract class Device {
  Device(this.bindings, this.index);

  /// Index of this device.
  final int index;

  /// Library handling this device.
  final Bindings bindings;

  /// Name of the device.
  String get name => Utf8.fromUtf8(bindings.get_device_name(index));

  /// Manufacturer name of the device, or null.
  String get manufacturerName {
    final buffer = allocate<Utf8>(count: 256);
    try {
      final error = bindings.get_device_usb_strings(index, buffer, nullptr, nullptr);
      if (error != 0) {
        return throw ArgumentError('$error');
      }
      return Utf8.fromUtf8(buffer);
    } finally {
      free(buffer);
    }
  }

  /// Product name of the device, or null.
  String get productName {
    final buffer = allocate<Utf8>(count: 256);
    try {
      final error = bindings.get_device_usb_strings(index, nullptr, buffer, nullptr);
      if (error != 0) {
        return throw ArgumentError('$error');
      }
      return Utf8.fromUtf8(buffer);
    } finally {
      free(buffer);
    }
  }

  /// Serial number of the device, or null.
  String get serialNumber {
    final buffer = allocate<Utf8>(count: 256);
    try {
      final error = bindings.get_device_usb_strings(index, nullptr, nullptr, buffer);
      if (error != 0) {
        return throw ArgumentError('$error');
      }
      return Utf8.fromUtf8(buffer);
    } finally {
      free(buffer);
    }
  }

  /// Open the given device.
  DeviceOpen open() {
    final handle = allocate<Pointer<DeviceHandle>>();
    final error = bindings.open(handle, index);
    if (error != 0) {
      throw new StateError('Unable to open device $index: $error');
    }
    return DeviceOpen(bindings, index, handle.value);
  }

  @override
  String toString() => name;
}
