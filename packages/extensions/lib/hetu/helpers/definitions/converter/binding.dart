import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './bytes/class.dart';
import './class.dart';
import '../../model.dart';

class ConverterClassBinding extends HTExternalClass {
  ConverterClassBinding() : super('Converter');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Converter.jsonEncode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.jsonEncode(positionalArgs[0]),
        );

      case 'Converter.jsonDecode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.jsonDecode(positionalArgs[0] as String),
        );

      case 'Converter.queryStringEncode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.queryStringEncode(
            parseHetuReturnedMap(positionalArgs[0]),
          ),
        );

      case 'Converter.queryStringDecode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.queryStringDecode(positionalArgs[0] as String),
        );

      case 'Converter.utf8Encode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.utf8Encode(positionalArgs[0] as String),
        );

      case 'Converter.utf8Decode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.utf8Decode(positionalArgs[0] as BytesContainer),
        );

      case 'Converter.base64Encode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.base64Encode(positionalArgs[0] as BytesContainer),
        );

      case 'Converter.base64Decode':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Converter.base64Decode(positionalArgs[0] as String),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
