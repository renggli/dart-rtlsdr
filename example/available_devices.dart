import 'package:rtlsdr/rtlsdr.dart';

/// Prints name and device strings of all available RTL-SDR devices.
void main() {
  for (final device in RtlSdr.devices) {
    print('Name: ${device.name}');
    print('Product: ${device.product}');
    print('Manufacturer: ${device.manufacturer}');
    print('Serial: ${device.serial}');
    print('');
  }
}
