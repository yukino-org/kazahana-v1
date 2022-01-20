import './binding.dart';
import '../../../../../model.dart';

final HetuHelperClass hChapterInfoClass = HetuHelperClass(
  definition: ChapterInfoClassBinding(),
  declaration: '''
external class ChapterInfo {
  /// ({
  ///   chapter: string,
  ///   url: string,
  ///   locale: string,
  ///   title: string?,
  ///   volume: string?,
  /// }) => ChapterInfo;
  construct({ chapter, url, locale, title, volume });

  /// string
  get chapter;
  
  /// string
  get url;
  
  /// string
  get locale;
  
  /// string?
  get title;
  
  /// string?
  get volume;

  /// () => Map<dynamic, dynamic>
  fun toJson();
}
      '''
      .trim(),
);
