import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hBytesContainerClass = HetuHelperClass(
  definition: BytesContainerClassBinding(),
  declaration: '''
external class BytesContainer {
  /// int[]
  get list;

  /// (int[]) => BytesContainer
  static fun fromList(data);
}
      '''
      .trim(),
);
