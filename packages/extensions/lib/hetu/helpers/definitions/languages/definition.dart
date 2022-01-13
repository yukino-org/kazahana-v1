import './binding.dart';
import '../../model.dart';

final HetuHelperClass hLanguagesClass = HetuHelperClass(
  definition: LanguagesClassBinding(),
  declaration: '''
external class Languages {
  static fun isValid(language);
  
  static get all;
}
      '''
      .trim(),
);
