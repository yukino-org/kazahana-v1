import './binding.dart';
import '../../../../../model.dart';

final HetuHelperClass hSearchInfoClass = HetuHelperClass(
  definition: SearchInfoClassBinding(),
  declaration: '''
external class SearchInfo {
  /// ({
  ///   title: string,
  ///   url: string,
  ///   locale: string,
  ///   thumbnail: ImageDescriber?,
  /// }) => SearchInfo;
  construct({ title, url, locale, thumbnail });

  /// string
  get title;
  
  /// string
  get url;
  
  /// string
  get locale;
  
  /// ImageDescriber?
  get thumbnail;

  /// () => Map<dynamic, dynamic>
  fun toJson();
}
      '''
      .trim(),
);
