import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hAnimeInfoClass = HetuHelperClass(
  definition: AnimeInfoClassBinding(),
  declaration: '''
external class AnimeInfo {
  construct({ title, url, episodes, locale, availableLocales, thumbnail });

  get title;
  get url;
  get episodes;
  get locale;
  get availableLocales;
  get thumbnail;

  fun toJson();
}
      '''
      .trim(),
);
