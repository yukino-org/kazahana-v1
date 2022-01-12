import './binding.dart';
import '../../model.dart';

final HetuHelperClass hRegexClass = HetuHelperClass(
  definition: RegexClassBinding(),
  declaration: '''
external class Regex {
  construct(regex: str);

  fun firstMatch(text);
  fun allMatches(text);
  fun replaceFirst(data, to);
  fun replaceAll(data, to);
}
      '''
      .trim(),
);
