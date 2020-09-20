import 'dart:math';
import 'dart:io';
import 'package:rtlsdr/rtlsdr.dart';

void main() async {
  for (final info in DeviceInfo.all) {
    print('Device: ${info.name}');

    final device = info.open();
    try {
      device.centerFrequency = 105800000;
      device.sampleRate = 2048000;

      print('Center Frequency: ${device.centerFrequency}Hz');
      print('Frequency correction: ${device.frequencyCorrection}ppm');
      print('Tuner type: ${device.tunerType}');
      print('Tuner gains: ${device.tunerGains.join(', ')}');
      print('Tuner gain: ${device.tunerGain}dB');
      print('Sample Rate: ${device.sampleRate}Hz');
      print('Direct sampling mode: ${device.directSamplingMode}');
      print('Offset tuning: ${device.offsetTuning}');

      await device.stream.forEach((data) {
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
      });
    } finally {
      device.close();
    }
  }
}
