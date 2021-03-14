import 'dart:io';

import 'package:rtlsdr/rtlsdr.dart';

/// Prints name and device strings of all available RTL-SDR devices.
void main() {
  for (final device in RtlSdr.devices) {
    stdout.writeln('Name: ${device.name}');
    stdout.writeln('Product: ${device.product}');
    stdout.writeln('Manufacturer: ${device.manufacturer}');
    stdout.writeln('Serial: ${device.serial}');
    stdout.writeln();
  }
}
