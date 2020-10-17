import 'dart:typed_data';

extension ToTypedDoubleListExtension on Stream<List<double>> {
  /// Copies the [double] values into a [List], see [List.of].
  Stream<List<double>> toDoubleList() => map((input) => List<double>.of(input));

  /// Copies the [double] values into an [Float32List], see [Float32List.fromList].
  Stream<Float32List> toFloat32List() =>
      map((input) => Float32List.fromList(input));

  /// Copies the [double] values into an [Float64List], see [Float64List.fromList].
  Stream<Float64List> toFloat64List() =>
      map((input) => Float64List.fromList(input));
}
