import 'dart:typed_data';

extension ToTypedIntListExtension on Stream<List<int>> {
  /// Copies the [int] values into a new [List].
  ///
  /// Example:
  /// ```dart
  /// intStream.toIntList().listen((list) => print(list));
  /// ```
  Stream<List<int>> toIntList() => map(List<int>.of);

  /// Copies the [int] values into a new [Int8List].
  ///
  /// Example:
  /// ```dart
  /// intStream.toInt8List().listen((list) => print(list));
  /// ```
  Stream<Int8List> toInt8List() => map(Int8List.fromList);

  /// Copies the [int] values into a new [Uint8ClampedList].
  ///
  /// Example:
  /// ```dart
  /// intStream.toUint8ClampedList().listen((list) => print(list));
  /// ```
  Stream<Uint8ClampedList> toUint8ClampedList() =>
      map(Uint8ClampedList.fromList);

  /// Copies the [int] values into a new [Uint8List].
  ///
  /// Example:
  /// ```dart
  /// intStream.toUint8List().listen((list) => print(list));
  /// ```
  Stream<Uint8List> toUint8List() => map(Uint8List.fromList);

  /// Copies the [int] values into a new [Int16List].
  ///
  /// Example:
  /// ```dart
  /// intStream.toInt16List().listen((list) => print(list));
  /// ```
  Stream<Int16List> toInt16List() => map(Int16List.fromList);

  /// Copies the [int] values into a new [Uint16List].
  ///
  /// Example:
  /// ```dart
  /// intStream.toUint16List().listen((list) => print(list));
  /// ```
  Stream<Uint16List> toUint16List() => map(Uint16List.fromList);

  /// Copies the [int] values into a new [Int32List].
  ///
  /// Example:
  /// ```dart
  /// intStream.toInt32List().listen((list) => print(list));
  /// ```
  Stream<Int32List> toInt32List() => map(Int32List.fromList);

  /// Copies the [int] values into a new [Uint32List].
  ///
  /// Example:
  /// ```dart
  /// intStream.toUint32List().listen((list) => print(list));
  /// ```
  Stream<Uint32List> toUint32List() => map(Uint32List.fromList);

  /// Copies the [int] values into a new [Uint64List].
  ///
  /// Example:
  /// ```dart
  /// intStream.toUint64List().listen((list) => print(list));
  /// ```
  Stream<Uint64List> toUint64List() => map(Uint64List.fromList);

  /// Copies the [int] values into a new [Int64List].
  ///
  /// Example:
  /// ```dart
  /// intStream.toInt64List().listen((list) => print(list));
  /// ```
  Stream<Int64List> toInt64List() => map(Int64List.fromList);
}
