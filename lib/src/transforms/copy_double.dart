import 'dart:typed_data';

extension ToTypedDoubleListExtension on Stream<List<double>> {
  /// Copies the [double] values into a [List], see [List.of].
  Stream<List<double>> toDoubleList() => map(List<double>.of);

  /// Copies the [double] values into an [Float32List], see
  /// [Float32List.fromList].
  Stream<Float32List> toFloat32List() => map(Float32List.fromList);

  /// Copies the [double] values into an [Float64List], see
  /// [Float64List.fromList].
  Stream<Float64List> toFloat64List() => map(Float64List.fromList);
}
