import 'dart:math';

import 'package:rtlsdr/rtlsdr.dart';

void main() {
  getDevices().forEach((device) {
    print('Device: ${device}');

    final deviceStrings = device.deviceStrings;
    print('Manufacturer: ${deviceStrings.manufacturerName}');
    print('Product: ${deviceStrings.productName}');
    print('Serial: ${deviceStrings.serialNumber}');

    final open = device.open();
    try {
      open.centerFrequency = 105800000;
      open.sampleRate = 2048000;

      print('Center Frequency: ${open.centerFrequency}Hz');
      print('Frequency correction: ${open.frequencyCorrection}ppm');
      print('Tuner type: ${open.tunerType}');
      print('Tuner gains: ${open.tunerGains.join(', ')}');
      print('Tuner gain: ${open.tunerGain}dB');
      print('Sample Rate: ${open.sampleRate}Hz');
      print('Direct sampling mode: ${open.directSamplingMode}');
      print('Offset tuning: ${open.offsetTuning}');

      var counter = 0;
      open.resetBuffer();
      open.readAsync((data) {
        for (var i = 0; i < min(10, data.length); i += 2) {
          final a = (data[i] - 127) / 127.0;
          final b = (data[i + 1] - 127) / 127.0;
          final r = sqrt(a * a + b * b);
          final p = atan2(a, b) * 180 / pi;
          print('I = ${a.toStringAsFixed(3)}  '
              'Q = ${b.toStringAsFixed(3)}  '
              'r = ${r.toStringAsFixed(3)}  '
              'p = ${p.toStringAsFixed(3)}  ');
        }
        print('---');
        return counter++ < 10;
      }, bufferCount: 1);
    } finally {
      open.close();
    }
  });
}
