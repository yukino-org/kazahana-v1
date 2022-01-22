import 'dart:async';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import './provider.dart';
import '../../../http.dart';
import '../../models/webview.dart';

const Duration _futureTimeout = Duration(seconds: 15);

class FlutterWebviewEventer {
  StreamController<Uri> onLoadController = StreamController<Uri>.broadcast();
  late Stream<Uri> onLoad = onLoadController.stream;

  Future<T> waitUntil<T>(
    final Stream<T> stream,
    final bool Function(T) fn,
  ) {
    final Completer<T> future = Completer<T>();
    StreamSubscription<T>? sub;

    sub = stream.listen((final T value) {
      if (fn(value)) {
        future.complete(value);
        sub?.cancel();
        sub = null;
      }
    });

    return future.future..timeout(_futureTimeout);
  }

  Future<void> dispose() async {
    await onLoadController.close();
    await onLoad.drain();
  }
}

class FlutterWebviewWebview extends Webview<FlutterWebviewProvider> {
  FlutterWebviewWebview({
    required final FlutterWebviewProvider provider,
  }) : super(provider: provider);

  HeadlessInAppWebView? webview;
  FlutterWebviewEventer? eventer = FlutterWebviewEventer();

  @override
  Future<void> initialize() async {
    webview = HeadlessInAppWebView(
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          userAgent: HttpUtils.userAgent,
        ),
      ),
      onLoadStop: (final InAppWebViewController controller, final Uri? uri) {
        if (uri != null) {
          eventer!.onLoadController.add(uri);
        }
      },
    );

    await webview!.run();
    await super.initialize();
  }

  @override
  Future<void> open(final String url, final WebviewWaitUntil waitUntil) async {
    beforeMethod();

    final Uri uri = Uri.parse(url);
    final Completer<void> future = Completer<void>();

    switch (waitUntil) {
      case WebviewWaitUntil.load:
        eventer!
            .waitUntil(
          eventer!.onLoad,
          (final Uri receivedUri) => true,
        )
            .then((final Uri uri) {
          future.complete();
        });

        break;

      case WebviewWaitUntil.domContentLoaded:
        eventer!
            .waitUntil(
          eventer!.onLoad,
          (final Uri receivedUri) => true,
        )
            .then((final Uri uri) async {
          await webview!.webViewController.callAsyncJavaScript(
            functionBody: '''
                  return new Promise((resolve) => {
                    if (document.readyState === 'complete') {
                      return resolve();
                    }

                    document.addEventListener('DOMContentLoaded', () => {
                      resolve();
                    });
                  });
                  ''',
          );
          future.complete();
        });
        break;

      case WebviewWaitUntil.none:
        future.complete();
        break;
    }

    await webview!.webViewController.loadUrl(
      urlRequest: URLRequest(
        url: uri,
        headers: headers,
      ),
    );

    return future.future..timeout(_futureTimeout);
  }

  @override
  Future<dynamic> evalJavascript(final String code) async {
    beforeMethod();

    final CallAsyncJavaScriptResult? result = await webview!.webViewController
        .callAsyncJavaScript(functionBody: code);

    return result?.value;
  }

  @override
  Future<String?> getHtml() async {
    beforeMethod();

    return webview!.webViewController.getHtml();
  }

  @override
  Future<Map<String, String>> getCookies(final String url) async {
    beforeMethod();

    final List<Cookie> got =
        await provider.cookies!.getCookies(url: Uri.parse(url));

    return got.asMap().map(
          (final int i, final Cookie x) =>
              MapEntry<String, String>(x.name, x.value.toString()),
        );
  }

  @override
  Future<void> deleteCookie(final String url, final String name) async {
    beforeMethod();

    await provider.cookies!.deleteCookie(url: Uri.parse(url), name: name);
  }

  @override
  Future<void> clearAllCookies() async {
    beforeMethod();

    await provider.cookies!.deleteAllCookies();
  }

  @override
  Future<void> dispose() async {
    await webview?.dispose();
    await eventer?.dispose();
    webview = eventer = null;

    await super.dispose();
  }
}
