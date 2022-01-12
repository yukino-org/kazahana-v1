import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';

class FuzzySearchResultItemClassBinding extends HTExternalClass {
  FuzzySearchResultItemClassBinding() : super('FuzzySearchResultItem');

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
