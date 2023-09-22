import 'dart:io';

import 'package:rtlsdr/rtlsdr.dart';

void main() async {
  // Grab the first RTLSDR device.
  final device = RtlSdr.devices.first;
  // Print its name.
  stdout.writeln(device.name);
  // Open device.
  device.open();
  try {
    // Tune in.
    device.centerFrequency = 105800000;
    device.sampleRate = 2048000;
    // Print some samples from the first chunk.
    final data = await device.stream.first;
    stdout.writeln(data.take(100).join(', '));
  } finally {
    // Close the device at the end.
    device.close();
  }
}
