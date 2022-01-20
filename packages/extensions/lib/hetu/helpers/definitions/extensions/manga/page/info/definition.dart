import './binding.dart';
import '../../../../../model.dart';

final HetuHelperClass hPageInfoClass = HetuHelperClass(
  definition: PageInfoClassBinding(),
  declaration: '''
external class PageInfo {
  /// ({
  ///   url: string,
  ///   locale: string,
  /// })
  construct({ url, locale });
  
  /// string
  get url;
  
  /// string
  get locale;

  /// () => Map<dynamic, dynamic>
  fun toJson();
}
      '''
      .trim(),
);
