import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hFuzzySearchResultItemClass = HetuHelperClass(
  definition: FuzzySearchResultItemClassBinding(),
  declaration: '''
external class FuzzySearchResultItem {
  final item;
  final score;
}
      '''
      .trim(),
);
