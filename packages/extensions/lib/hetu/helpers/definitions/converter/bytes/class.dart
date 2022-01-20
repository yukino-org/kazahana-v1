import 'dart:typed_data';

class BytesContainer {
  const BytesContainer(this.bytes);

  factory BytesContainer.fromList(final List<int> list) =>
      BytesContainer(Uint8List.fromList(list));

  final Uint8List bytes;

  List<int> get list => bytes.toList();
}
