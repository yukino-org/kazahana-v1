import 'package:path/path.dart' as path;
import 'package:tenka/tenka.dart';
import 'package:utilx/webview/webview.dart';
import 'package:utilx_desktop/webview/puppeteer/provider.dart';
import 'package:utilx_mobile/webview/providers/flutter_inappwebview/provider.dart';
import '../config/paths.dart';
import 'app/state.dart';
import 'helpers/logger.dart';

abstract class TenkaManager {
  static late final TenkaRepository repository;

  static final Map<String, dynamic> _cachedExtractors = <String, dynamic>{};
  static final Logger _logger = Logger.of('TenkaManager');

  static Future<void> initialize() async {
    _logger.info('Initializing internals');
    await TenkaInternals.initialize(
      runtime: TenkaRuntimeOptions(
        http: TenkaRuntimeHttpClientOptions(
          ignoreSSLCertificate:
              AppState.settings.value.developers.ignoreBadHttpCertificate,
        ),
        webview: WebviewManagerInitializeOptions(
          webviewProvider,
          WebviewProviderOptions(
            localChromiumPath: path.join(PathDirs.otherData, 'local-chromium'),
          ),
        ),
      ),
    );

    _logger.info('Initializing repository');
    repository = TenkaRepository(
      resolver: const TenkaStoreURLResolver(),
      baseDir: PathDirs.tenka,
    );
    await repository.initialize();

    _logger.info('Initialized successfully');
  }

  static Future<T> getExtractor<T>(final TenkaMetadata metadata) async {
    if (!_cachedExtractors.containsKey(metadata.id)) {
      final TenkaRuntimeInstance runtime = await TenkaRuntimeManager.create();
      await runtime.loadScriptCode('', appendDefinitions: true);
      await runtime.loadByteCode((metadata.source as TenkaBase64DS).data);
      _cachedExtractors[metadata.id] = await runtime.getExtractor<T>();
    }

    return _cachedExtractors[metadata.id] as T;
  }

  static String resolveTenkaCloudDSURL(final TenkaCloudDS source) =>
      '$defaultStoreBaseURL/${source.url}';

  static WebviewProvider<dynamic> get webviewProvider =>
      (AppState.isDesktop ? PuppeteerProvider() : FlutterWebviewProvider())
          as WebviewProvider<dynamic>;

  static String get defaultStoreBaseURL => repository.store.baseURLs['github']!;
}
