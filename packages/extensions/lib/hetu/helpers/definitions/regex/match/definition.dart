import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hRegexMatchClass = HetuHelperClass(
  definition: RegexMatchClassBinding(),
  declaration: '''
external class RegexMatch {
  final input: str;
  
  fun group(group: num);
}
      '''
      .trim(),
);
