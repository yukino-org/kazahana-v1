import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';
import '../../model.dart';
import '../task_trace/class.dart';

class FlawClassBinding extends HTExternalClass {
  FlawClassBinding() : super('Flaw');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Flaw':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Flaw(
            positionalArgs[0] as String,
            positionalArgs[1] as String?,
            positionalArgs[2] as TaskTrace?,
          ),
        );

      case 'Flaw.throwFlaw':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Flaw.throwFlaw(
            positionalArgs[0],
            positionalArgs[1] as TaskTrace?,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final Flaw element = object as Flaw;

    switch (varName) {
      case 'err':
        return element.err;

      case 'stack':
        return element.err;

      case 'task':
        return element.err;

      case 'toString':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.toString(),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
