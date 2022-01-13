import 'package:utilx/utilities/locale.dart';

class EpisodeInfo {
  const EpisodeInfo({
    required final this.episode,
    required final this.url,
    required final this.locale,
  });

  factory EpisodeInfo.fromJson(final Map<dynamic, dynamic> json) => EpisodeInfo(
        episode: json['episode'] as String,
        url: json['url'] as String,
        locale: Locale.parse(json['locale'] as String),
      );

  final String episode;
  final String url;
  final Locale locale;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'episode': episode,
        'url': url,
        'locale': locale.toCodeString(),
      };
}
