import 'dart:typed_data';

extension AmplitudeExtension on Stream<Uint8List> {
  /// In-place converts a stream of IQ data to a stream of peak amplitude data.
  ///
  /// The input is a [Stream<Uint8List>] of interleaved I- and Q-samples.
  /// The output is a [Stream<Uint16List>] of peak amplitudes.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .toAmplitude()
  ///   .listen((amplitudes) => print(amplitudes));
  /// ```
  Stream<Uint16List> toAmplitude() => map((input) {
    final amplitude = _amplitude;
    final result = Uint16List.sublistView(input, 0, input.length);
    for (var i = 0, j = 0; i < result.length; i++, j += 2) {
      result[i] = amplitude[(input[j] << 8) | input[j + 1]];
    }
    return result;
  });
}

final _amplitude = _precomputeAmplitude();

Uint16List _precomputeAmplitude() {
  final result = Uint16List(256 * 256);
  for (var i = 0; i < 256; i++) {
    final iSquared = _squared(i - 127.5);
    for (var q = 0; q < 256; q++) {
      final qSquared = _squared(q - 127.5);
      result[(i << 8) | q] = (iSquared + qSquared).round();
    }
  }
  return result;
}

double _squared(double value) => value * value;
