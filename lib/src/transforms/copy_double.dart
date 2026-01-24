import 'dart:typed_data';

extension ToTypedDoubleListExtension on Stream<List<double>> {
  /// Copies the [double] values into a new [List].
  ///
  /// Example:
  /// ```dart
  /// doubleStream.toDoubleList().listen((list) => print(list));
  /// ```
  Stream<List<double>> toDoubleList() => map(List<double>.of);

  /// Copies the [double] values into a new [Float32List].
  ///
  /// Example:
  /// ```dart
  /// doubleStream.toFloat32List().listen((list) => print(list));
  /// ```
  Stream<Float32List> toFloat32List() => map(Float32List.fromList);

  /// Copies the [double] values into a new [Float64List].
  ///
  /// Example:
  /// ```dart
  /// doubleStream.toFloat64List().listen((list) => print(list));
  /// ```
  Stream<Float64List> toFloat64List() => map(Float64List.fromList);
}
