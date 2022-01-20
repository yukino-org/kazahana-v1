import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import './key/class.dart';
import './result_item/class.dart';

class FuzzySearch {
  FuzzySearch({
    required final this.items,
    required final this.keys,
  });

  final List<dynamic> items;
  final List<FuzzySearchKey> keys;

  late final Fuzzy<dynamic> _client = Fuzzy<dynamic>(
    items,
    options: FuzzyOptions<dynamic>(
      keys: keys
          .asMap()
          .map(
            (final int i, final FuzzySearchKey x) =>
                MapEntry<int, WeightedKey<dynamic>>(
              i,
              WeightedKey<dynamic>(
                name: i.toString(),
                getter: (final dynamic data) =>
                    x.getter.call(positionalArgs: <dynamic>[data]) as String,
                weight: x.weight,
              ),
            ),
          )
          .values
          .toList(),
    ),
  );

  List<FuzzySearchResultItem> search(final String search, [final int? limit]) {
    final List<FuzzySearchResultItem> results = _client
        .search(search)
        .map(
          (final Result<dynamic> x) => FuzzySearchResultItem(
            item: x.item,
            score: x.score,
          ),
        )
        .toList();

    return limit != null && limit <= results.length
        ? results.sublist(0, limit)
        : results;
  }
}
