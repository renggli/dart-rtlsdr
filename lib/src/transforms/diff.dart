import 'dart:convert';

extension DiffConverterExtension<T extends num, L extends List<T>>
    on Stream<L> {
  /// Returns a stream with the difference between consecutive elements.
  Stream<L> toDiff() => transform(DiffConverter<T, L>());
}

class DiffConverter<T extends num, L extends List<T>> extends Converter<L, L> {
  @override
  L convert(L input) {
    final sink =
        ChunkedConversionSink<L>.withCallback((result) => input = result.first);
    startChunkedConversion(sink)
      ..add(input)
      ..close();
    return input;
  }

  @override
  Sink<L> startChunkedConversion(Sink<L> sink) => DiffSink<T, L>(sink);
}

class DiffSink<T extends num, L extends List<T>>
    extends ChunkedConversionSink<L> {
  final Sink<L> sink;

  bool first = true;
  T previous;

  DiffSink(this.sink);

  @override
  void add(L chunk) {
    if (first && chunk.isNotEmpty) {
      previous = chunk.first;
      chunk = chunk.sublist(1);
      first = false;
    }
    for (var i = 0; i < chunk.length; i++) {
      final current = chunk[i];
      chunk[i] = current - previous;
      previous = current;
    }
    sink.add(chunk);
  }

  @override
  void close() => sink.close();
}
