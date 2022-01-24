import 'package:hetu_script/binding.dart';
import './definitions/clock/definition.dart';
import './definitions/collection/definition.dart';
import './definitions/converter/bytes/definition.dart';
import './definitions/converter/definition.dart';
import './definitions/crypto/definition.dart';
import './definitions/extensions/anime/episode/info/definition.dart';
import './definitions/extensions/anime/episode/source/definition.dart';
import './definitions/extensions/anime/info/definition.dart';
import './definitions/extensions/base/image_describer/definition.dart';
import './definitions/extensions/base/search/info/definition.dart';
import './definitions/extensions/manga/chapter/info/definition.dart';
import './definitions/extensions/manga/info/definition.dart';
import './definitions/extensions/manga/page/info/definition.dart';
import './definitions/flaw/definition.dart';
import './definitions/fuzzy/definition.dart';
import './definitions/fuzzy/key/definition.dart';
import './definitions/fuzzy/result_item/definition.dart';
import './definitions/html/definition.dart';
import './definitions/http/definition.dart';
import './definitions/http/result/definition.dart';
import './definitions/languages/definition.dart';
import './definitions/promise/definition.dart';
import './definitions/regex/definition.dart';
import './definitions/regex/match/definition.dart';
import './definitions/string/format/definition.dart';
import './definitions/task_trace/definition.dart';
import './definitions/webview/definition.dart';
import './model.dart';

abstract class HetuHelperExports {
  static final List<HetuHelperClass> classes = <HetuHelperClass>[
    hClockClass,
    hCollectionClass,
    hBytesContainerClass,
    hConverterClass,
    hCryptoClass,
    hEpisodeInfoClass,
    hEpisodeSourceClass,
    hAnimeInfoClass,
    hImageDescriberClass,
    hSearchInfoClass,
    hChapterInfoClass,
    hMangaInfoClass,
    hPageInfoClass,
    hFlawClass,
    hFuzzySearchClass,
    hFuzzySearchKeyClass,
    hFuzzySearchResultItemClass,
    hHtmlElementClass,
    hHttpClass,
    hHttpResponseClass,
    hLanguagesClass,
    hPromiseClass,
    hRegexClass,
    hRegexMatchClass,
    hTaskTraceClass,
    hWebviewClass,
  ];

  static final List<HetuHelperFunction> functions = <HetuHelperFunction>[
    hStrFmtFunction,
  ];

  static List<HTExternalClass> get externalClasses =>
      classes.map((final HetuHelperClass x) => x.definition).toList();

  static Map<String, Function> get externalFunctions => functions.asMap().map(
        (final int i, final HetuHelperFunction x) =>
            MapEntry<String, Function>(x.name, x.definition),
      );

  static String get declarations => <String>[
        ...classes.map((final HetuHelperClass x) => x.declaration),
        ...functions.map((final HetuHelperFunction x) => x.declaration),
      ].join('\n');
}
