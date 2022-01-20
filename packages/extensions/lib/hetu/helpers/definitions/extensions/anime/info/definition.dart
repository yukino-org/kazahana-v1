import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hAnimeInfoClass = HetuHelperClass(
  definition: AnimeInfoClassBinding(),
  declaration: '''
external class AnimeInfo {
  /// ({
  ///   title: string,
  ///   url: string,
  ///   episodes: EpisodeInfo[],
  ///   locale: string,
  ///   availableLocales: string[],
  ///   thumbnail: ImageDescriber?,
  /// }) => AnimeInfo;
  construct({ title, url, episodes, locale, availableLocales, thumbnail });

  /// string
  get title;
  
  /// string
  get url;
  
  /// EpisodeInfo[]
  get episodes;
  
  /// string
  get locale;
  
  /// string[]
  get availableLocales;
  
  /// ImageDescriber?
  get thumbnail;

  /// () => Map<dynamic, dynamic>
  fun toJson();
}
      '''
      .trim(),
);
