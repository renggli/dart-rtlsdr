import 'package:rtlsdr/rtlsdr.dart';

/// Prints all name and device strings of all available devices.
void main() {
  for (final info in DeviceInfo.all) {
    print('Name: ${info.name}');
    print('Product: ${info.product}');
    print('Manufacturer: ${info.manufacturer}');
    print('Serial: ${info.serial}');
    print('');
  }
}
