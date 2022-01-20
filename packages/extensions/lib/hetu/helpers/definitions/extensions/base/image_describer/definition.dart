import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hImageDescriberClass = HetuHelperClass(
  definition: ImageDescriberClassBinding(),
  declaration: '''
external class ImageDescriber {
  /// ({
  ///   url: string,
  ///   headers: Map<string, string>,
  /// }) => ImageDescriber;
  construct({ url, headers });
  
  /// string
  get url;
  
  /// Map<string, string>
  get headers;

  /// () => Map<dynamic, dynamic>
  fun toJson();
}
      '''
      .trim(),
);
