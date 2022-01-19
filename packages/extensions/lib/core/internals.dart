import 'package:hetu_script/hetu_script.dart';
import 'package:utilx/utilities/locale.dart';
import './resolved.dart';
import '../hetu/helpers/definitions/http/client.dart';
import '../hetu/hetu.dart';
import '../models/exports.dart';
import '../utils/webview/webview.dart';

export './base.dart';
export './resolvable.dart';
export './resolved.dart';
export '../hetu/helpers/definitions/http/client.dart' show HttpClientOptions;
export '../utils/webview/webview.dart' show WebviewProviderOptions;

abstract class ExtensionInternals {
  static Future<void> initialize({
    required final HttpClientOptions httpOptions,
    required final WebviewProviderOptions webviewProviderOptions,
  }) async {
    await WebviewManager.initialize(webviewProviderOptions);
    HetuHttpClient.initialize(httpOptions);
  }

  static Future<void> dispose() async {
    await WebviewManager.dispose();
  }

  static Future<String> _getDefaultLocale(final Hetu runner) async {
    try {
      return runner.invoke('defaultLocale') as String;
    } on HTError catch (err, stack) {
      await Future<void>.error(HetuManager.getModifiedError(err), stack);
      // To keep the compiler quiet
      rethrow;
    }
  }

  static Future<AnimeExtractor> transpileToAnimeExtractor(
    final ResolvedExtension ext,
  ) async {
    final Hetu runner = await HetuManager.create();

    try {
      await runner.eval(HetuManager.prependDefinitions(ext.code));
    } on HTError catch (err, stack) {
      await Future<void>.error(HetuManager.getModifiedError(err), stack);
      rethrow;
    }

    final Locale defaultLocale = Locale.parse(await _getDefaultLocale(runner));

    return AnimeExtractor(
      name: ext.name,
      id: ext.id,
      defaultLocale: defaultLocale,
      search: (final String terms, final Locale locale) async {
        try {
          final dynamic result = await runner.invoke(
            'search',
            positionalArgs: <dynamic>[
              terms,
              locale.toCodeString(),
            ],
          );

          return (result as List<dynamic>).cast<SearchInfo>().toList();
        } on HTError catch (err, stack) {
          await Future<void>.error(HetuManager.getModifiedError(err), stack);
          rethrow;
        }
      },
      getInfo: (final String url, final Locale locale) async {
        try {
          final dynamic result = await runner.invoke(
            'getInfo',
            positionalArgs: <dynamic>[
              url,
              locale.toCodeString(),
            ],
          );

          return result as AnimeInfo;
        } on HTError catch (err, stack) {
          await Future<void>.error(HetuManager.getModifiedError(err), stack);
          rethrow;
        }
      },
      getSources: (final EpisodeInfo episode) async {
        try {
          final dynamic result = await runner.invoke(
            'getSources',
            positionalArgs: <dynamic>[
              episode,
            ],
          );

          return (result as List<dynamic>).cast<EpisodeSource>().toList();
        } on HTError catch (err, stack) {
          await Future<void>.error(HetuManager.getModifiedError(err), stack);
          rethrow;
        }
      },
    );
  }

  static Future<MangaExtractor> transpileToMangaExtractor(
    final ResolvedExtension ext,
  ) async {
    final Hetu runner = await HetuManager.create();

    try {
      await runner.eval(HetuManager.prependDefinitions(ext.code));
    } on HTError catch (err, stack) {
      await Future<void>.error(HetuManager.getModifiedError(err), stack);
      rethrow;
    }

    final Locale defaultLocale = Locale.parse(await _getDefaultLocale(runner));

    return MangaExtractor(
      name: ext.name,
      id: ext.id,
      defaultLocale: defaultLocale,
      search: (final String terms, final Locale locale) async {
        try {
          final dynamic result = await runner.invoke(
            'search',
            positionalArgs: <dynamic>[
              terms,
              locale.toCodeString(),
            ],
          );

          return (result as List<dynamic>).cast<SearchInfo>().toList();
        } on HTError catch (err, stack) {
          await Future<void>.error(HetuManager.getModifiedError(err), stack);
          rethrow;
        }
      },
      getInfo: (final String url, final Locale locale) async {
        try {
          final dynamic result = await runner.invoke(
            'getInfo',
            positionalArgs: <dynamic>[
              url,
              locale.toCodeString(),
            ],
          );

          return result as MangaInfo;
        } on HTError catch (err, stack) {
          await Future<void>.error(HetuManager.getModifiedError(err), stack);
          rethrow;
        }
      },
      getChapter: (final ChapterInfo chapter) async {
        try {
          final dynamic result = await runner.invoke(
            'getChapter',
            positionalArgs: <dynamic>[
              chapter,
            ],
          );

          return (result as List<dynamic>).cast<PageInfo>().toList();
        } on HTError catch (err, stack) {
          await Future<void>.error(HetuManager.getModifiedError(err), stack);
          rethrow;
        }
      },
      getPage: (final PageInfo page) async {
        try {
          final dynamic result = await runner.invoke(
            'getPage',
            positionalArgs: <dynamic>[
              page,
            ],
          );

          return result as ImageDescriber;
        } on HTError catch (err, stack) {
          await Future<void>.error(HetuManager.getModifiedError(err), stack);
          rethrow;
        }
      },
    );
  }
}
