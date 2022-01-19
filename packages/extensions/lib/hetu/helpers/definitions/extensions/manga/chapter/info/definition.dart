import './binding.dart';
import '../../../../../model.dart';

final HetuHelperClass hChapterInfoClass = HetuHelperClass(
  definition: ChapterInfoClassBinding(),
  declaration: '''
external class ChapterInfo {
  construct({ chapter, url, locale, title, volume });

  get chapter;
  get url;
  get locale;
  get title;
  get volume;

  fun toJson();
}
      '''
      .trim(),
);
