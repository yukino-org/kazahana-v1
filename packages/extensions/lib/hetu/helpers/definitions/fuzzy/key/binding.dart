import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/value/function/function.dart';
import './class.dart';
import '../../../model.dart';

class FuzzySearchKeyClassBinding extends HTExternalClass {
  FuzzySearchKeyClassBinding() : super('FuzzySearchKey');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'FuzzySearchKey':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              FuzzySearchKey(
            getter: namedArgs['getter'] as HTFunction,
            weight:
                namedArgs['weight'] as double? ?? FuzzySearchKey.defaultWeight,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final FuzzySearchKey element = object as FuzzySearchKey;

    switch (varName) {
      case 'getter':
        return element.getter;

      case 'weight':
        return element.weight;

      default:
        throw HTError.undefined(varName);
    }
  }
}
