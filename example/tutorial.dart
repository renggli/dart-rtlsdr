import 'package:rtlsdr/rtlsdr.dart';
import 'dart:io';

void main() async {
  // Grab the first RTLSDR device and print its name.
  final device = RtlSdr.devices.first;
  stdout.writeln(device.name);

  // Open device.
  device.open();
  try {
    // Tune in.
    device.centerFrequency = 105800000;
    device.sampleRate = 2048000;

    // Print some samples from the first chunk.
    final data = await device.stream.first;
    stdout.writeln(data.take(25));
  } finally {
    // Close the device at the end.
    device.close();
  }
}
