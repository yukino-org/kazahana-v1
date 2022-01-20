import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hFuzzySearchResultItemClass = HetuHelperClass(
  definition: FuzzySearchResultItemClassBinding(),
  declaration: '''
external class FuzzySearchResultItem {
  /// ({
  ///   item: T,
  ///   score: float,
  /// })<T = any> => FuzzySearchResultItem;
  construct({ item, score });

  /// T
  final item;

  /// float
  final score;
}
      '''
      .trim(),
);
