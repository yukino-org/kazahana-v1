import 'dart:typed_data';

class BytesContainer {
  const BytesContainer(this.bytes);

  factory BytesContainer.fromList(final List<int> list) =>
      BytesContainer(Uint8List.fromList(list));

  final Uint8List bytes;

  BytesContainer addSingleByte(final int data) =>
      BytesContainer.fromList(list..add(data));

  BytesContainer add(final BytesContainer data) =>
      BytesContainer.fromList(list..addAll(data.list));

  BytesContainer sublist(final int start, [final int? end]) =>
      BytesContainer(bytes.sublist(start, end));

  BytesContainer clone() => BytesContainer(bytes.sublist(0));

  int get length => bytes.length;

  List<int> get list => bytes.toList();
}
