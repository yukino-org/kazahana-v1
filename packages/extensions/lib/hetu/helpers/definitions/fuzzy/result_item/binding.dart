import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';
import '../../../model.dart';

class FuzzySearchResultItemClassBinding extends HTExternalClass {
  FuzzySearchResultItemClassBinding() : super('FuzzySearchResultItem');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'FuzzySearchResultItem':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              FuzzySearchResultItem(
            item: namedArgs['item'],
            score: namedArgs['score'] as double,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final FuzzySearchResultItem element = object as FuzzySearchResultItem;

    switch (varName) {
      case 'item':
        return element.item;

      case 'score':
        return element.score;

      default:
        throw HTError.undefined(varName);
    }
  }
}
