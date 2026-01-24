import 'dart:typed_data';

extension ComponentExtension on Stream<Uint8List> {
  /// In-place extracts the I-component from the input stream.
  ///
  /// The input is a [Stream<Uint8List>] of interleaved I- and Q-samples.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .toComponentI()
  ///   .listen((iSamples) => print(iSamples));
  /// ```
  Stream<Uint8List> toComponentI() => map((input) {
    final result = Uint8List.sublistView(input, 0, input.length ~/ 2);
    for (var i = 0, j = 0; i < result.length; i++, j += 2) {
      result[i] = input[j];
    }
    return result;
  });

  /// In-place extracts the Q-component from the input stream.
  ///
  /// The input is a [Stream<Uint8List>] of interleaved I- and Q-samples.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .toComponentQ()
  ///   .listen((qSamples) => print(qSamples));
  /// ```
  Stream<Uint8List> toComponentQ() => map((input) {
    final result = Uint8List.sublistView(input, 0, input.length ~/ 2);
    for (var i = 0, j = 1; i < result.length; i++, j += 2) {
      result[i] = input[j];
    }
    return result;
  });
}
