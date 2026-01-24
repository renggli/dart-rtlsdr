import 'dart:typed_data';

extension AsTypedListExtension<T extends TypedData> on Stream<T> {
  /// Creates [ByteData] views over the underlying data buffers.
  ///
  /// Uses [ByteBuffer.asByteData] for the conversion.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .asByteData()
  ///   .listen((byteData) => print(byteData.lengthInBytes));
  /// ```
  Stream<ByteData> asByteData() => map(
    (input) =>
        input.buffer.asByteData(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Int8List] views over the underlying data buffers.
  ///
  /// Uses [ByteBuffer.asInt8List] for the conversion.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .asInt8List()
  ///   .listen((list) => print(list));
  /// ```
  Stream<Int8List> asInt8List() => map(
    (input) =>
        input.buffer.asInt8List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Uint8List] views over the underlying data buffers.
  ///
  /// Uses [ByteBuffer.asUint8List] for the conversion.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .asUint8List()
  ///   .listen((list) => print(list));
  /// ```
  Stream<Uint8List> asUint8List() => map(
    (input) =>
        input.buffer.asUint8List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Uint8ClampedList] views over the underlying data buffer, see
  /// [ByteBuffer.asUint8ClampedList] for details.
  Stream<Uint8ClampedList> asUint8ClampedList() => map(
    (input) => input.buffer.asUint8ClampedList(
      input.offsetInBytes,
      input.lengthInBytes,
    ),
  );

  /// Creates [Int16List] views over the underlying data buffers.
  ///
  /// Uses [ByteBuffer.asInt16List] for the conversion.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .asInt16List()
  ///   .listen((list) => print(list));
  /// ```
  Stream<Int16List> asInt16List() => map(
    (input) =>
        input.buffer.asInt16List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Uint16List] views over the underlying data buffers.
  ///
  /// Uses [ByteBuffer.asUint16List] for the conversion.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .asUint16List()
  ///   .listen((list) => print(list));
  /// ```
  Stream<Uint16List> asUint16List() => map(
    (input) =>
        input.buffer.asUint16List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Int32List] views over the underlying data buffer, see
  /// [ByteBuffer.asInt32List] for details.
  Stream<Int32List> asInt32List() => map(
    (input) =>
        input.buffer.asInt32List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Uint32List] views over the underlying data buffers.
  ///
  /// Uses [ByteBuffer.asUint32List] for the conversion.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .asUint32List()
  ///   .listen((list) => print(list));
  /// ```
  Stream<Uint32List> asUint32List() => map(
    (input) =>
        input.buffer.asUint32List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Uint64List] views over the underlying data buffer, see
  /// [ByteBuffer.asUint64List] for details.
  Stream<Uint64List> asUint64List() => map(
    (input) =>
        input.buffer.asUint64List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Int64List] views over the underlying data buffer, see
  /// [ByteBuffer.asInt64List] for details.
  Stream<Int64List> asInt64List() => map(
    (input) =>
        input.buffer.asInt64List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Int32x4List] views over the underlying data buffer, see
  /// [ByteBuffer.asInt32x4List] for details.
  Stream<Int32x4List> asInt32x4List() => map(
    (input) =>
        input.buffer.asInt32x4List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Float32List] views over the underlying data buffers.
  ///
  /// Uses [ByteBuffer.asFloat32List] for the conversion.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .asFloat32List()
  ///   .listen((list) => print(list));
  /// ```
  Stream<Float32List> asFloat32List() => map(
    (input) =>
        input.buffer.asFloat32List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Float64List] views over the underlying data buffers.
  ///
  /// Uses [ByteBuffer.asFloat64List] for the conversion.
  ///
  /// Example:
  /// ```dart
  /// device.stream
  ///   .asFloat64List()
  ///   .listen((list) => print(list));
  /// ```
  Stream<Float64List> asFloat64List() => map(
    (input) =>
        input.buffer.asFloat64List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Float32x4List] views over the underlying data buffer, see
  /// [ByteBuffer.asFloat32x4List] for details.
  Stream<Float32x4List> asFloat32x4List() => map(
    (input) =>
        input.buffer.asFloat32x4List(input.offsetInBytes, input.lengthInBytes),
  );

  /// Creates [Float64x2List] views over the underlying data buffer, see
  /// [ByteBuffer.asFloat64x2List] for details.
  Stream<Float64x2List> asFloat64x2List() => map(
    (input) =>
        input.buffer.asFloat64x2List(input.offsetInBytes, input.lengthInBytes),
  );
}
