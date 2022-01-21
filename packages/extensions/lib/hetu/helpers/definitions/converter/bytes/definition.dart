import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hBytesContainerClass = HetuHelperClass(
  definition: BytesContainerClassBinding(),
  declaration: '''
external class BytesContainer {
  // Returns current instance
  /// (int) => BytesContainer
  fun addSingleByte(data);
  
  // Returns current instance
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
