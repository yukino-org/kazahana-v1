import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hMangaInfoClass = HetuHelperClass(
  definition: MangaInfoClassBinding(),
  declaration: '''
external class MangaInfo {
  construct({ title, url, episodes, locale, availableLocales, thumbnail });
}
      '''
      .trim(),
);
