import 'dart:io';
import 'dart:math';

import 'package:rtlsdr/rtlsdr.dart';

void main() {
  getDevices().forEach((device) {
    stdout.write('Device: ${device}');

    final deviceStrings = device.deviceStrings;
    stdout.write('Manufacturer: ${deviceStrings.manufacturerName}');
    stdout.write('Product: ${deviceStrings.productName}');
    stdout.write('Serial: ${deviceStrings.serialNumber}');

    final open = device.open();
    try {
      open.centerFrequency = 105800000;
      open.sampleRate = 2048000;

      stdout.write('Center Frequency: ${open.centerFrequency}Hz');
      stdout.write('Frequency correction: ${open.frequencyCorrection}ppm');
      stdout.write('Tuner type: ${open.tunerType}');
      stdout.write('Tuner gains: ${open.tunerGains.join(', ')}');
      stdout.write('Tuner gain: ${open.tunerGain}dB');
      stdout.write('Sample Rate: ${open.sampleRate}Hz');
      stdout.write('Direct sampling mode: ${open.directSamplingMode}');
      stdout.write('Offset tuning: ${open.offsetTuning}');

      var counter = 0;
      open.resetBuffer();
      open.readAsync((data) {
        for (var i = 0; i < min(10, data.length); i += 2) {
          final a = (data[i] - 127) / 127.0;
          final b = (data[i + 1] - 127) / 127.0;
          final r = sqrt(a * a + b * b);
          final p = atan2(a, b) * 180 / pi;
          stdout.write('I = ${a.toStringAsFixed(3)}  '
              'Q = ${b.toStringAsFixed(3)}  '
              'r = ${r.toStringAsFixed(3)}  '
              'p = ${p.toStringAsFixed(3)}  ');
        }
        stdout.write('---');
        return counter++ < 10;
      }, bufferCount: 1);
    } finally {
      open.close();
    }
  });
}
