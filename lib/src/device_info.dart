import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:more/collection.dart';

import 'device.dart';
import 'ffi/bindings.dart';
import 'utils/errors.dart';

/// Information about a specific RTL-SDR device.
class DeviceInfo {
  //// Return an iterable over all accessible RTL-SDR device information.
  static Iterable<DeviceInfo> get all {
    final result = bindings.get_device_count();
    DeviceException.checkError(result, 'Unable to read number of devices.');
    return 0.to(result).map((index) => DeviceInfo(index));
  }

  // Some internally cached data.
  String _name;
  String _manufacturer;
  String _product;
  String _serial;

  /// Constructs device information.
  DeviceInfo(this.index);

  /// Opens this device.
  Device open() => Device.fromInfo(this);

  /// The index of the device.
  final int index;

  /// Tests if this is a valid device.
  bool get isValid {
    _updateDeviceName();
    return _name.isNotEmpty;
  }

  /// The name of the device.
  String get name {
    if (_name == null) {
      _updateDeviceName();
    }
    return _name;
  }

  /// The manufacturer of the device.
  String get manufacturer {
    if (_manufacturer == null) {
      _updateDeviceStrings();
    }
    return _manufacturer;
  }

  /// The product name of the device.
  String get product {
    if (_product == null) {
      _updateDeviceStrings();
    }
    return _product;
  }

  /// The serial number of the device.
  String get serial {
    if (_serial == null) {
      _updateDeviceStrings();
    }
    return _serial;
  }

  /// Internal helper to retrieve the device name.
  void _updateDeviceName() {
    _name = null;
    final result = bindings.get_device_name(index);
    _name = Utf8.fromUtf8(result);
  }

  /// Internal helper to retrieve the device strings.
  void _updateDeviceStrings() {
    _manufacturer = _product = _serial = null;
    final manufacturer = allocate<Uint8>(count: 256).cast<Utf8>();
    try {
      final product = allocate<Uint8>(count: 256).cast<Utf8>();
      try {
        final serial = allocate<Uint8>(count: 256).cast<Utf8>();
        try {
          final result = bindings.get_device_usb_strings(
              index, manufacturer, product, serial);
          DeviceException.checkError(
              result, 'Unable to get strings of device $index.');
          _manufacturer = Utf8.fromUtf8(manufacturer);
          _product = Utf8.fromUtf8(product);
          _serial = Utf8.fromUtf8(serial);
        } finally {
          free(serial);
        }
      } finally {
        free(product);
      }
    } finally {
      free(manufacturer);
    }
  }

  @override
  String toString() => 'DeviceInfo{${name}}';
}
