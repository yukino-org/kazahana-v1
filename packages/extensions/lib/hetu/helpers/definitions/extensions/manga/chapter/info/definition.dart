import './binding.dart';
import '../../../../../model.dart';

final HetuHelperClass hChapterInfoClass = HetuHelperClass(
  definition: ChapterInfoClassBinding(),
  declaration: '''
external class ChapterInfo {
  construct({ chapter, url, episodes, locale, title, volume });
}
      '''
      .trim(),
);
