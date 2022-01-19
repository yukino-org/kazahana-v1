import './binding.dart';
import '../../../../../model.dart';

final HetuHelperClass hSearchInfoClass = HetuHelperClass(
  definition: SearchInfoClassBinding(),
  declaration: '''
external class SearchInfo {
  construct({ title, url, locale, thumbnail });

  get title;
  get url;
  get locale;
  get thumbnail;

  fun toJson();
}
      '''
      .trim(),
);
