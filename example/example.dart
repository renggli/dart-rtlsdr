import 'package:rtlsdr/rtlsdr.dart';

void main() {
  getDevices().forEach((device) {
    print('${device}');
    print('Manufacturer: ${device.manufacturerName}');
    print('Product: ${device.productName}');
    print('Serial: ${device.serialNumber}');
  });
}
