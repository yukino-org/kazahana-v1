import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:utilx/utilities/locale.dart';
import '../../../../../../models/base/image_describer.dart';
import '../../../../../../models/manga/chapter/info.dart';
import '../../../../../../models/manga/info.dart';
import '../../../../model.dart';

class MangaInfoClassBinding extends HTExternalClass {
  MangaInfoClassBinding() : super('MangaInfo');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'MangaInfo':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              MangaInfo(
            title: namedArgs['title'] as String,
            url: namedArgs['url'] as String,
            chapters:
                (namedArgs['chapters'] as List<dynamic>).cast<ChapterInfo>(),
            locale: Locale.parse(namedArgs['locale'] as String),
            availableLocales: (namedArgs['availableLocales'] as List<dynamic>)
                .map((final dynamic x) => Locale.parse(x as String))
                .toList(),
            thumbnail: namedArgs['thumbnail'] as ImageDescriber?,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}