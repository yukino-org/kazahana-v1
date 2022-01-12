import './binding.dart';
import '../../model.dart';

final HetuHelperClass hLanguagesClass = HetuHelperClass(
  definition: LanguagesClassBinding(),
  declaration: '''
external class Languages {
  static final all;

  static fun isValid(language);
}
      '''
      .trim(),
);
