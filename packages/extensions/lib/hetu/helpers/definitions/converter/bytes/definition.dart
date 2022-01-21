import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hBytesContainerClass = HetuHelperClass(
  definition: BytesContainerClassBinding(),
  declaration: '''
external class BytesContainer {
  /// (BytesContainer) => void
  fun add(data);

  /// (int, [int?]) => BytesContainer
  fun clone(start, end);

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
