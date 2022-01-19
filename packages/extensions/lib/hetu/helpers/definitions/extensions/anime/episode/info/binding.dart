import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:utilx/utilities/locale.dart';
import '../../../../../../../models/anime/episode/info.dart';
import '../../../../../model.dart';

class EpisodeInfoClassBinding extends HTExternalClass {
  EpisodeInfoClassBinding() : super('EpisodeInfo');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'EpisodeInfo':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              EpisodeInfo(
            episode: namedArgs['episode'] as String,
            url: namedArgs['url'] as String,
            locale: Locale.parse(namedArgs['locale'] as String),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final EpisodeInfo element = object as EpisodeInfo;

    switch (varName) {
      case 'episode':
        return element.episode;

      case 'url':
        return element.url;

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
