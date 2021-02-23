import 'dart:typed_data';

import 'package:rtlsdr/rtlsdr.dart';

const sampleRate = 2048000;

mixin Analyzer {
  void call(Uint8List buffer);
}

class UnderRunAnalyzer implements Analyzer {
  int _index = 0;
  int _last = 0;
  bool _first = true;

  int seenSamples = 0;
  int lostSamples = 0;
  Map<int, int> lostSamplesPerBuffer = {};

  @override
  void call(Uint8List buffer) {
    _index++;
    if (buffer.isEmpty) {
      return;
    }
    if (_first) {
      _last = buffer.first;
      _first = false;
    }
    var lost = 0;
    for (var i = 0; i < buffer.length; i++) {
      if (_last != buffer[i]) {
        lost += (buffer[i] - _last).abs();
        _last = buffer[i];
      }
      _last = (_last + 1) & 0xff;
    }
    seenSamples += buffer.length;
    lostSamples += lost;
    if (lost > 0) {
      lostSamplesPerBuffer[_index] = lost;
    }
  }

  @override
  String toString() => lostSamples > 0
      ? 'Lost $lostSamples (${100 * lostSamples / seenSamples}%) in $seenSamples samples in buffer ${lostSamplesPerBuffer.keys.join(', ')}.'
      : 'Lost no samples in $seenSamples samples.';
}

class SampleAnalyzer implements Analyzer {
  int nsamples = 0;
  Duration interval = Duration.zero;
  int nsamples_total = 0;
  Duration interval_total = Duration.zero;
  DateTime? recentTime;

  @override
  void call(Uint8List buffer) {
    final timeNow = DateTime.now();
    if (recentTime == null) {
      recentTime = timeNow;
      return;
    }

    nsamples += buffer.length ~/ 2;
    interval = timeNow.difference(recentTime!);

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
}

Future<void> main() async {
  final device = RtlSdr();
  device.open();
  final analyzerList = [UnderRunAnalyzer(), SampleAnalyzer()];
  try {
    device.testMode = true;
    device.sampleRate = sampleRate;
    await device.stream.take(10).forEach((buffer) {
      for (final analyzer in analyzerList) {
        analyzer(buffer);
      }
    });
  } finally {
    analyzerList.forEach(print);
    device.close();
  }
}
