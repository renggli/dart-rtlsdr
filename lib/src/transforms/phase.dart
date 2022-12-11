import 'dart:math';
import 'dart:typed_data';

extension PhaseExtension on Stream<Uint8List> {
  /// In-place converts a stream of IQ data into a stream of phase data, scaled
  /// to pi = 1 << 14.
  Stream<Int16List> toPhase() => map((input) {
        final phase = _phase;
        final result = Int16List.sublistView(input, 0, input.length);
        for (var i = 0, j = 0; i < result.length; i++, j += 2) {
          result[i] = phase[(input[j] << 8) | input[j + 1]];
        }
        return result;
      });
}

final _phase = _precomputePhase();

Int16List _precomputePhase() {
  const scale = (1 << 12) / pi;
  final result = Int16List(256 * 256);
  for (var i = 0; i < 256; i++) {
    for (var q = 0; q < 256; q++) {
      final value = atan2(q - 127.5, i - 127.5) * scale;
      result[(i << 8) | q] = value.round();
    }
  }
  return result;
}
