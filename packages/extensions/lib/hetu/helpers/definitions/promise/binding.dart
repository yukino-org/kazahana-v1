import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/value/function/function.dart';
import '../../model.dart';
import 'class.dart';

class PromiseClassBinding extends HTExternalClass {
  PromiseClassBinding() : super('Promise');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Promise.resolve':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Promise.resolve(
            positionalArgs[0] as HTFunction,
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Promise.resolveAll':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Promise.resolveAll(
            (positionalArgs[0] as List<dynamic>).cast<HTFunction>(),
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Promise.wait':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Promise.wait(
            positionalArgs[0] as int,
            positionalArgs[1] as HTFunction,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
