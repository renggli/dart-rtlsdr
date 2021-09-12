import 'dart:io';
import 'dart:typed_data';

import 'package:rtlsdr/rtlsdr.dart';

const sampleRate = 2048000;

mixin Analyzer {
  void update(Uint8List buffer);
}

class UnderRunAnalyzer implements Analyzer {
  int _index = 0;
  int _last = 0;
  bool _first = true;

  int seenSamples = 0;
  int lostSamples = 0;
  Map<int, int> lostSamplesPerBuffer = {};

  @override
  void update(Uint8List buffer) {
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
      ? 'Lost $lostSamples (${100 * lostSamples / seenSamples}%) in '
          '$seenSamples samples in buffer '
          '${lostSamplesPerBuffer.keys.join(', ')}.'
      : 'Lost no samples in $seenSamples samples.';
}

class SampleAnalyzer implements Analyzer {
  int nsamples = 0;
  Duration interval = Duration.zero;
  int nsamplesTotal = 0;
  Duration intervalTotal = Duration.zero;
  DateTime? recentTime;

  @override
  void update(Uint8List buffer) {
    final timeNow = DateTime.now();
    if (recentTime == null) {
      recentTime = timeNow;
      return;
    }

    nsamples += buffer.length ~/ 2;
    interval = timeNow.difference(recentTime!);

    if (interval < const Duration(seconds: 2)) {
      return;
    }

    nsamplesTotal += nsamples;
    intervalTotal += interval;

    final currentSampleRate = 1e6 * nsamples / interval.inMicroseconds;
    stdout.writeln('current sample rate: ${currentSampleRate.round()}');
    final currentPpm = 1e6 * (currentSampleRate / sampleRate - 1.0);
    stdout.writeln('current ppm: ${currentPpm.round()}');

    final cumulativeSampleRate =
        1e6 * nsamplesTotal / intervalTotal.inMicroseconds;
    stdout.writeln('cumulative sample rate: ${cumulativeSampleRate.round()}');
    final cumulativePpm = 1e6 * (cumulativeSampleRate / sampleRate - 1.0);
    stdout.writeln('cumulative ppm: ${cumulativePpm.round()}');

    recentTime = timeNow;
    nsamples = 0;
  }
}

Future<void> main() async {
  final device = RtlSdr()..open();
  final analyzerList = [UnderRunAnalyzer(), SampleAnalyzer()];
  try {
    device.testMode = true;
    device.sampleRate = sampleRate;
    await device.stream.take(100).forEach((buffer) {
      for (final analyzer in analyzerList) {
        analyzer.update(buffer);
      }
    });
  } finally {
    analyzerList.forEach(stdout.writeln);
    device.close();
  }
}
