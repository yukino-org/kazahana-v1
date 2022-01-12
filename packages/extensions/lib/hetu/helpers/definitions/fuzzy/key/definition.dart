import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hFuzzySearchKeyClass = HetuHelperClass(
  definition: FuzzySearchKeyClassBinding(),
  declaration: '''
external class FuzzyKey {
  construct({ getter, weight });

  final getter;
  final weight;
}
      '''
      .trim(),
);
