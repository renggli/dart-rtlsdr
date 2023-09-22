import 'dart:typed_data';

extension ToTypedIntListExtension on Stream<List<int>> {
  /// Copies the [int] values into a [List], see [List.of].
  Stream<List<int>> toIntList() => map(List<int>.of);

  /// Copies the [int] values into an [Int8List], see [Int8List.fromList].
  Stream<Int8List> toInt8List() => map(Int8List.fromList);

  /// Copies the [int] values into an [Uint8ClampedList], see
  /// [Uint8ClampedList.fromList].
  Stream<Uint8ClampedList> toUint8ClampedList() =>
      map(Uint8ClampedList.fromList);

  /// Copies the [int] values into an [Uint8List], see [Uint8List.fromList].
  Stream<Uint8List> toUint8List() => map(Uint8List.fromList);

  /// Copies the [int] values into an [Int16List], see [Int16List.fromList].
  Stream<Int16List> toInt16List() => map(Int16List.fromList);

  /// Copies the [int] values into an [Uint16List], see [Uint16List.fromList].
  Stream<Uint16List> toUint16List() => map(Uint16List.fromList);

  /// Copies the [int] values into an [Int32List], see [Uint8List.fromList].
  Stream<Int32List> toInt32List() => map(Int32List.fromList);

  /// Copies the [int] values into an [Uint32List], see [Uint32List.fromList].
  Stream<Uint32List> toUint32List() => map(Uint32List.fromList);

  /// Copies the [int] values into an [Uint64List], see [Uint64List.fromList].
  Stream<Uint64List> toUint64List() => map(Uint64List.fromList);

  /// Copies the [int] values into an [Int64List], see [Int64List.fromList].
  Stream<Int64List> toInt64List() => map(Int64List.fromList);
}
