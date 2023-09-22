import 'dart:async';
import 'dart:typed_data';

extension WindowListExtension<T> on Stream<List<T>> {
  Stream<List<T>> window(int size) => expand((list) {
        final result = <List<T>>[];
        for (var i = 0; i < list.length; i += size) {
          result.add(list.sublist(i, i + size));
        }
        return result;
      });
}

extension WindowUint8ListExtension<T> on Stream<Uint8List> {
  Stream<Uint8List> window(int size) =>
      _window<Uint8List>(this, size, Uint8List.sublistView);
}

extension WindowInt8ListExtension<T> on Stream<Int8List> {
  Stream<Int8List> window(int size) =>
      _window<Int8List>(this, size, Int8List.sublistView);
}

extension WindowUint16ListExtension<T> on Stream<Uint16List> {
  Stream<Uint16List> window(int size) =>
      _window<Uint16List>(this, size, Uint16List.sublistView);
}

extension WindowInt16ListExtension<T> on Stream<Int8List> {
  Stream<Int8List> window(int size) =>
      _window<Int8List>(this, size, Int8List.sublistView);
}

extension WindowUint32ListExtension<T> on Stream<Uint32List> {
  Stream<Uint32List> window(int size) =>
      _window<Uint32List>(this, size, Uint32List.sublistView);
}

extension WindowInt32ListExtension<T> on Stream<Int32List> {
  Stream<Int32List> window(int size) =>
      _window<Int32List>(this, size, Int32List.sublistView);
}

Stream<T> _window<T extends List<int>>(Stream<T> stream, int size,
        T Function(T list, int start, int stop) sublist) =>
    stream.expand((data) {
      final result = <T>[];
      for (var i = 0; i < data.length; i += size) {
        result.add(sublist(data, i, i + size));
      }
      return result;
    });
