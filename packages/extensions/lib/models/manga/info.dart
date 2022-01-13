import 'package:utilx/utilities/locale.dart';
import './chapter/info.dart';
import '../base/image_describer.dart';

class MangaInfo {
  const MangaInfo({
    required final this.url,
    required final this.title,
    required final this.chapters,
    required final this.locale,
    required final this.availableLocales,
    final this.thumbnail,
  });

  factory MangaInfo.fromJson(final Map<dynamic, dynamic> json) => MangaInfo(
        title: json['title'] as String,
        url: json['url'] as String,
        chapters: (json['chapters'] as List<dynamic>)
            .cast<Map<dynamic, dynamic>>()
            .map((final Map<dynamic, dynamic> x) => ChapterInfo.fromJson(x))
            .toList(),
        thumbnail: json['thumbnail'] != null
            ? ImageDescriber.fromJson(
                json['thumbnail'] as Map<dynamic, dynamic>,
              )
            : null,
        locale: Locale.parse(json['locale'] as String),
        availableLocales: (json['availableLocales'] as List<dynamic>)
            .cast<String>()
            .map((final String x) => Locale.parse(x))
            .toList(),
      );

  final String title;
  final String url;
  final List<ChapterInfo> chapters;
  final ImageDescriber? thumbnail;
  final Locale locale;
  final List<Locale> availableLocales;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'title': title,
        'url': url,
        'thumbnail': thumbnail?.toJson(),
        'chapters': chapters.map((final ChapterInfo x) => x.toJson()).toList(),
        'locale': locale.toCodeString(),
        'availableLocales':
            availableLocales.map((final Locale x) => x.toCodeString()).toList(),
      };
}
