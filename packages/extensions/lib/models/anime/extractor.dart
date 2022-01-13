import 'package:utilx/utilities/locale.dart';
import './episode/info.dart';
import './episode/source.dart';
import './info.dart';
import '../base/extractor.dart';

typedef GetAnimeInfoFn = Future<AnimeInfo> Function(String, Locale);

typedef GetSourcesFn = Future<List<EpisodeSource>> Function(EpisodeInfo);

class AnimeExtractor extends BaseExtractor {
  const AnimeExtractor({
    required final String name,
    required final String id,
    required final SearchFn search,
    required final Locale defaultLocale,
    required final this.getInfo,
    required final this.getSources,
  }) : super(
          name: name,
          id: id,
          search: search,
          defaultLocale: defaultLocale,
        );

  final GetAnimeInfoFn getInfo;
  final GetSourcesFn getSources;
}
