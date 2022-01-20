import './binding.dart';
import '../../model.dart';

final HetuHelperClass hRegexClass = HetuHelperClass(
  definition: RegexClassBinding(),
  declaration: '''
external class Regex {
  // [regex] must be escaped since slashes are not preserved
  /// (string) => Regex;
  construct(regex: str);

  /// (string) => RegexMatch?
  fun firstMatch(text);

  /// (string) => RegexMatch[]
  fun allMatches(text);

  /// (string, string) => string
  fun replaceFirst(data, to);

  /// (string, string) => string
  fun replaceAll(data, to);
}
      '''
      .trim(),
);
