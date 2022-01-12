import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import './class.dart';
import '../../model.dart';

class CollectionClassBinding extends HTExternalClass {
  CollectionClassBinding() : super('Collection');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Collection.rangeList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.rangeList(
            positionalArgs[0] as int,
            positionalArgs[1] as int,
          ),
        );

      case 'Collection.mergeList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.mergeList(
            positionalArgs[0] as List<dynamic>,
            positionalArgs[1] as List<dynamic>,
          ),
        );

      case 'Collection.eachList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.eachList(
            positionalArgs[0] as List<dynamic>,
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.mapList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.mapList(
            positionalArgs[0] as List<dynamic>,
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.filterList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.filterList(
            positionalArgs[0] as List<dynamic>,
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.findList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.findList(
            positionalArgs[0] as List<dynamic>,
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.flattenList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.flattenList(
            positionalArgs[0] as List<dynamic>,
            positionalArgs[1] as int,
          ),
        );

      case 'Collection.deepFlattenList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.deepFlattenList(positionalArgs[0] as List<dynamic>),
        );

      case 'Collection.mergeMap':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.mergeMap(
            positionalArgs[0] as Map<dynamic, dynamic>,
            positionalArgs[1] as Map<dynamic, dynamic>,
          ),
        );

      case 'Collection.eachMap':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.eachMap(
            positionalArgs[0] as Map<dynamic, dynamic>,
            positionalArgs[1] as HTFunction,
          ),
        );

      case 'Collection.mapToList':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Collection.mapToList(
            positionalArgs[0] as Map<dynamic, dynamic>,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
