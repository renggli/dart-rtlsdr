import 'package:rtlsdr/rtlsdr.dart';

void main() {
  // Grab the first RTLSDR device and print its name.
  final device = getDevices()[0];
  print(device.name);

  // Open device and tune-in.
  final open = device.open();
  try {
    open.centerFrequency = 105800000;
    open.sampleRate = 2048000;

    // Read some data.
    open.resetBuffer();
    open.readAsync((data) {
      print('${data.sublist(0, 100).join(', ')} ...');
      return false; // continue?
    });
  } finally {
    // Close the device at the end.
    open.close();
  }
}
