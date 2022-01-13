import 'dart:async';
import './models/provider.dart';
import './providers/flutter_inappwebview/provider.dart';
import './providers/puppeteer/provider.dart';

export './models/provider.dart';
export './models/webview.dart';

abstract class WebviewManager {
  static bool ready = false;

  static late final WebviewProvider<dynamic> provider;

  static Future<void> initialize(final WebviewProviderOptions options) async {
    if (!ready) {
      if (FlutterWebviewProvider.isSupported()) {
        provider = FlutterWebviewProvider();
      } else if (PuppeteerProvider.isSupported()) {
        provider = PuppeteerProvider();
      } else {
        throw Exception('No DOM provider was found');
      }

      await provider.initialize(options);
      ready = true;
    }
  }

  static Future<void> dispose() async {
    await provider.dispose();
  }
}
