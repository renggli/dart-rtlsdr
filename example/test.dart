import 'dart:typed_data';

import 'package:rtlsdr/rtlsdr.dart';

const sampleRate = 2048000;

int bcnt;
bool firstUnderrun = true;
int total_samples = 0;
int dropped_samples = 0;
int bufferNo = 0;

void verifyUnderrun(Uint8List buffer) {
  if (firstUnderrun) {
    bcnt = buffer[0];
    firstUnderrun = false;
  }

  var lost = 0;
  for (var i = 0; i < buffer.length; i++) {
    if (bcnt != buffer[i]) {
      lost += (buffer[i] > bcnt) ? (buffer[i] - bcnt) : (bcnt - buffer[i]);
      bcnt = buffer[i];
    }
    bcnt = (bcnt + 1) & 0xff;
  }

  total_samples += buffer.length;
  dropped_samples += lost;

  if (lost > 0) {
    print('lost at least ${lost} bytes in buffer ${bufferNo}');
  }
  ++bufferNo;
}

int nsamples = 0;
Duration interval = Duration.zero;
int nsamples_total = 0;
Duration interval_total = Duration.zero;
DateTime recentTime;

void sampleTest(Uint8List buffer) {
  final timeNow = DateTime.now();
  if (recentTime == null) {
    recentTime = timeNow;
    return;
  }

  nsamples += buffer.length ~/ 2;
  interval = timeNow.difference(recentTime);

  if (interval < const Duration(seconds: 10)) {
    return;
  }

  nsamples_total += nsamples;
  interval_total += interval;

  final currentSampleRate = 1e6 * nsamples / interval.inMicroseconds;
  print('current sample rate: ${currentSampleRate.round()}');
  final currentPpm = 1e6 * (currentSampleRate / sampleRate - 1.0);
  print('current ppm: ${currentPpm.round()}');

  final cumulativeSampleRate =
      1e6 * nsamples_total / interval_total.inMicroseconds;
  print('cumulative sample rate: ${cumulativeSampleRate.round()}');
  final cumulativePpm = 1e6 * (cumulativeSampleRate / sampleRate - 1.0);
  print('cumulative ppm: ${cumulativePpm.round()}');

  recentTime = timeNow;
  nsamples = 0;
}

Future<void> main() async {
  final device = RtlSdr();
  device.open();
  try {
    device.testMode = true;
    device.sampleRate = sampleRate;
    await device.stream.forEach((buffer) {
      verifyUnderrun(buffer);
      sampleTest(buffer);
    });
  } finally {
    device.close();
  }
}
