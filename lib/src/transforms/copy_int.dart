import 'dart:typed_data';

extension ToTypedIntListExtension on Stream<List<int>> {
  /// Copies the [int] values into a [List], see [List.of].
  Stream<List<int>> toIntList() => map((input) => List<int>.of(input));

  /// Copies the [int] values into an [Int8List], see [Int8List.fromList].
  Stream<Int8List> toInt8List() => map((input) => Int8List.fromList(input));

  /// Copies the [int] values into an [Uint8ClampedList], see
  /// [Uint8ClampedList.fromList].
  Stream<Uint8ClampedList> toUint8ClampedList() =>
      map((input) => Uint8ClampedList.fromList(input));

  /// Copies the [int] values into an [Uint8List], see [Uint8List.fromList].
  Stream<Uint8List> toUint8List() => map((input) => Uint8List.fromList(input));

  /// Copies the [int] values into an [Int16List], see [Int16List.fromList].
  Stream<Int16List> toInt16List() => map((input) => Int16List.fromList(input));

  /// Copies the [int] values into an [Uint16List], see [Uint16List.fromList].
  Stream<Uint16List> toUint16List() =>
      map((input) => Uint16List.fromList(input));

  /// Copies the [int] values into an [Int32List], see [Uint8List.fromList].
  Stream<Int32List> toInt32List() => map((input) => Int32List.fromList(input));

  /// Copies the [int] values into an [Uint32List], see [Uint32List.fromList].
  Stream<Uint32List> toUint32List() =>
      map((input) => Uint32List.fromList(input));

  /// Copies the [int] values into an [Uint64List], see [Uint64List.fromList].
  Stream<Uint64List> toUint64List() =>
      map((input) => Uint64List.fromList(input));

  /// Copies the [int] values into an [Int64List], see [Int64List.fromList].
  Stream<Int64List> toInt64List() => map((input) => Int64List.fromList(input));
}
