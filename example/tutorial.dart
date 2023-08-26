import 'package:rtlsdr/rtlsdr.dart';

void main() async {
  // Grab the first RTLSDR device and print its name.
  final device = RtlSdr.devices.first;
  print(device.name);

  // Open device.
  device.open();
  try {
    // Tune in.
    device.centerFrequency = 105800000;
    device.sampleRate = 2048000;

    // Print some samples from the first chunk.
    final data = await device.stream.first;
    print(data.take(25));
  } finally {
    // Close the device at the end.
    device.close();
  }
}
