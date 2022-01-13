import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';
import '../../model.dart';

class TaskTraceClassBinding extends HTExternalClass {
  TaskTraceClassBinding() : super('TaskTrace');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'TaskTrace':
        return ({
          final List<dynamic> positionalArgs = const <dynamic>[],
          final Map<String, dynamic> namedArgs = const <String, dynamic>{},
          final List<HTType> typeArgs = const <HTType>[],
        }) =>
            TaskTrace();

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final TaskTrace element = object as TaskTrace;
    switch (varName) {
      case 'add':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.add(positionalArgs[0] as String),
        );

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
