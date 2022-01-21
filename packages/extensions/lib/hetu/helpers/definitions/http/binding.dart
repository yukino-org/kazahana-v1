import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';
import '../../model.dart';

class HttpClassBinding extends HTExternalClass {
  HttpClassBinding() : super('Http');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Http.fetch':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Http.fetch(
            method: namedArgs['method'] as String,
            url: namedArgs['url'] as String,
            headers: parseHetuReturnedMap(namedArgs['headers'])
                .cast<String, String>(),
            body: namedArgs['body'] as String?,
          ),
        );

      case 'Http.ensureURL':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Http.ensureURL(positionalArgs[0] as String),
        );

      case 'Http.defaultUserAgent':
        return Http.defaultUserAgent;

      default:
        throw HTError.undefined(varName);
    }
  }
}
