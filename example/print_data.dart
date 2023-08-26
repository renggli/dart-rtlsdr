import 'dart:io';
import 'dart:math';

import 'package:rtlsdr/rtlsdr.dart';

/// Asynchronously processes 10 packages of IQ-data.
Future<void> main() async {
  final device = RtlSdr()..open();
  try {
    device.centerFrequency = 105800000;
    device.sampleRate = 256000;
    await device.stream.take(10).forEach((data) {
      for (var i = 0; i < min(10, data.length); i += 2) {
        final a = (data[i] - 127.0) / 127.0;
        final b = (data[i + 1] - 127.0) / 127.0;
        final r = sqrt(a * a + b * b);
        final p = atan2(b, a) * 180 / pi;
        stdout.writeln('I = ${a.toStringAsFixed(3)}  '
            'Q = ${b.toStringAsFixed(3)}  '
            'r = ${r.toStringAsFixed(3)}  '
            'p = ${p.toStringAsFixed(3)}  ');
      }
    });
  } finally {
    device.close();
  }
}
