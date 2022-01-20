import './binding.dart';
import '../../../../model.dart';

final HetuHelperClass hMangaInfoClass = HetuHelperClass(
  definition: MangaInfoClassBinding(),
  declaration: '''
external class MangaInfo {
  /// ({
  ///   title: string,
  ///   url: string,
  ///   chapters: ChapterInfo[],
  ///   locale: string,
  ///   availableLocales: string[],
  ///   thumbnail: ImageDescriber?,
  /// }) => MangaInfo;
  construct({ title, url, chapters, locale, availableLocales, thumbnail });
  
  /// string
  get title;
  
  /// string
  get url;
  
  /// ChapterInfo[]
  get chapters;
  
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
