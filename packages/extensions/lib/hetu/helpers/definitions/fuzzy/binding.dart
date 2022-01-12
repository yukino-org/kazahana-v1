import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import './class.dart';
import './key/class.dart';
import '../../model.dart';

class FuzzySearchClassBinding extends HTExternalClass {
  FuzzySearchClassBinding() : super('FuzzySearch');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'FuzzySearch':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              FuzzySearch(
            items: (namedArgs['items'] as List<dynamic>)
                .cast<Map<dynamic, dynamic>>(),
            keys: (namedArgs['keys'] as List<dynamic>).map((final dynamic x) {
              final HTInstance keyObject = x as HTInstance;

              return FuzzySearchKey(
                getter: keyObject.memberGet('getter') as HTFunction,
                weight: keyObject.memberGet('weight') as double,
              );
            }).toList(),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final FuzzySearch element = object as FuzzySearch;

    switch (varName) {
      case 'search':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.search(
            positionalArgs[0] as String,
            positionalArgs[1] as int?,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}