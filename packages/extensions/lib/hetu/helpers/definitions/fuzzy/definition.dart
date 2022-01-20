import './binding.dart';
import '../../model.dart';

final HetuHelperClass hFuzzySearchClass = HetuHelperClass(
  definition: FuzzySearchClassBinding(),
  declaration: '''
external class FuzzySearch {
  /// ({
  ///   items: T[],
  ///   keys: FuzzySearchKey[],
  /// })<T> => FuzzySearch;
  construct({ items, keys });

  /// T[]
  get items;

  /// FuzzySearchKey[]
  get keys;

  /// (string, int?) => FuzzySearchResultItem<T>[];
  fun search(search, [limit]);
}
      '''
      .trim(),
);
