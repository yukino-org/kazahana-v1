import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hImageDescriberClass = HetuHelperClass(
  definition: ImageDescriberClassBinding(),
  declaration: '''
external class ImageDescriber {
  construct({ url, headers });

  get url;
  get headers;

  fun toJson();
}
      '''
      .trim(),
);
