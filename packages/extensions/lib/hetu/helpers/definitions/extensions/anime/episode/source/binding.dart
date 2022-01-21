import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:utilx/utilities/locale.dart';
import '../../../../../../../models/anime/episode/quality.dart';
import '../../../../../../../models/anime/episode/source.dart';
import '../../../../../model.dart';

class EpisodeSourceClassBinding extends HTExternalClass {
  EpisodeSourceClassBinding() : super('EpisodeSource');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'EpisodeSource':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              EpisodeSource(
            url: namedArgs['url'] as String,
            quality: Quality.parse(namedArgs['quality'] as String),
            headers: parseHetuReturnedMap(namedArgs['headers'])
                .cast<String, String>(),
            locale: Locale.parse(namedArgs['locale'] as String),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final EpisodeSource element = object as EpisodeSource;

    switch (varName) {
      case 'url':
        return element.url;

      case 'quality':
        return element.quality.code;

      case 'headers':
        return element.headers;

      case 'locale':
        return element.locale.toCodeString();

      case 'toJson':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.toJson(),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
