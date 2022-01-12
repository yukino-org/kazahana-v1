import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hRegexMatchClass = HetuHelperClass(
  definition: RegexMatchClassBinding(),
  declaration: '''
external class RegExpMatchResult {
  const input: str;
  
  fun group(group: num); // -> String?
}
      '''
      .trim(),
);
