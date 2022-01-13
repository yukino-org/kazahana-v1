import 'package:utilx/utilities/locale.dart';
import './search/info.dart';

typedef SearchFn = Future<List<SearchInfo>> Function(
  String terms,
  Locale locale,
);

class BaseExtractor {
  const BaseExtractor({
    required final this.name,
    required final this.id,
    required final this.search,
    required final this.defaultLocale,
  });

  final String name;
  final String id;
  final Locale defaultLocale;
  final SearchFn search;
}
