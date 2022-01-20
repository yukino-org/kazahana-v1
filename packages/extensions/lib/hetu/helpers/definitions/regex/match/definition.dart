import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hRegexMatchClass = HetuHelperClass(
  definition: RegexMatchClassBinding(),
  declaration: '''
external class RegexMatch {
  /// string
  final input;
  
  /// (int) => string?
  fun group(group);
}
      '''
      .trim(),
);
