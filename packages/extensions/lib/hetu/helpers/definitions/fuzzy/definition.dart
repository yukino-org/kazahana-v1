import './binding.dart';
import '../../model.dart';

final HetuHelperClass hFuzzySearchClass = HetuHelperClass(
  definition: FuzzySearchClassBinding(),
  declaration: '''
external class FuzzySearch {
  construct({ items, keys });

  fun search(search, [limit]);
}
      '''
      .trim(),
);
