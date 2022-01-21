import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hBytesContainerClass = HetuHelperClass(
  definition: BytesContainerClassBinding(),
  declaration: '''
external class BytesContainer {
  /// (BytesContainer) => void
  fun add(data);

  /// () => BytesContainer
  fun clone();

  /// int[]
  get list;

  /// (int[]) => BytesContainer
  static fun fromList(data);
}
      '''
      .trim(),
);
