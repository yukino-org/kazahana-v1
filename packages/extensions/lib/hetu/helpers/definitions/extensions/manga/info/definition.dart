import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hMangaInfoClass = HetuHelperClass(
  definition: MangaInfoClassBinding(),
  declaration: '''
external class MangaInfo {
  construct({ title, url, chapters, locale, availableLocales, thumbnail });

  get title;
  get url;
  get chapters;
  get locale;
  get availableLocales;
  get thumbnail;

  fun toJson();
}
      '''
      .trim(),
);
