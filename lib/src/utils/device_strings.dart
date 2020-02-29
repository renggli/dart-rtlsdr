library rtlsdr.utils.device_strings;

import 'package:meta/meta.dart';

@immutable
class DeviceStrings {
  /// Manufacturer name of the device.
  final String manufacturerName;

  /// Product name of the device.
  final String productName;

  /// Serial number of the device.
  final String serialNumber;

  const DeviceStrings(
      this.manufacturerName, this.productName, this.serialNumber);
}
