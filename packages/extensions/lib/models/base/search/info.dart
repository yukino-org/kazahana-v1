import 'package:utilx/utilities/locale.dart';
import '../image_describer.dart';

class SearchInfo {
  const SearchInfo({
    required final this.title,
    required final this.url,
    required final this.locale,
    final this.thumbnail,
  });

  factory SearchInfo.fromJson(final Map<dynamic, dynamic> json) => SearchInfo(
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnail: json['thumbnail'] != null
            ? ImageDescriber.fromJson(
                json['thumbnail'] as Map<dynamic, dynamic>,
              )
            : null,
        locale: Locale.parse(json['locale'] as String),
      );

  final String title;
  final String url;
  final ImageDescriber? thumbnail;
  final Locale locale;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'title': title,
        'url': url,
        'thumbnail': thumbnail?.toJson(),
        'locale': locale.toCodeString(),
      };
}
