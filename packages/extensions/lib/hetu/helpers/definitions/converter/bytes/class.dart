import 'dart:typed_data';

class BytesContainer {
  const BytesContainer(this.bytes);

  factory BytesContainer.fromList(final List<int> list) =>
      BytesContainer(Uint8List.fromList(list));

  final Uint8List bytes;

  void add(final BytesContainer data) {
    bytes.addAll(data.bytes);
  }

  BytesContainer sublist(final int start, [final int? end]) =>
      BytesContainer(bytes.sublist(start, end));

  BytesContainer clone() => BytesContainer(bytes.sublist(0));

  int get length => bytes.length;

  List<int> get list => bytes.toList();
}
