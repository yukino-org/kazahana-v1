import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hBytesContainerClass = HetuHelperClass(
  definition: BytesContainerClassBinding(),
  declaration: '''
external class BytesContainer {
  /// (int) => BytesContainer
  fun addSingleByte(data);
  
  /// (BytesContainer) => BytesContainer
  fun add(data);

  /// (int, [int?]) => BytesContainer
  fun sublist(start, end);

  /// () => BytesContainer
  fun clone();

  /// int
  get length;

  /// int[]
  get list;

  /// (int[]) => BytesContainer
  static fun fromList(data);
}
      '''
      .trim(),
);
