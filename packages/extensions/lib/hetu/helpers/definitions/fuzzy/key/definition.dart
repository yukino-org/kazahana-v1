import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hFuzzySearchKeyClass = HetuHelperClass(
  definition: FuzzySearchKeyClassBinding(),
  declaration: '''
external class FuzzySearchKey {
  /// ({
  ///   getter: (T) => string,
  ///   weight: float?,
  /// })<T = any> => FuzzySearchKey;
  construct({ getter, weight });

  /// (T) => string
  final getter;
  
  /// float
  final weight;
}
      '''
      .trim(),
);
