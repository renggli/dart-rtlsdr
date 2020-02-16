import 'package:rtlsdr/rtlsdr.dart';
import 'package:rtlsdr/src/devices.dart';

void main() {
  getDevices().forEach((device) {
    print('Name:         $device');
    print('Manufacturer: ${device.manufacturerName}');
    print('Product:      ${device.productName}');
    print('Serial:       ${device.serialNumber}');
  });
}
