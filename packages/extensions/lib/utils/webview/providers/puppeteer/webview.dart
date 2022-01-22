import 'package:puppeteer/protocol/network.dart';
import 'package:puppeteer/puppeteer.dart';
import './provider.dart';
import '../../../http.dart';
import '../../models/webview.dart';

class PuppeteerWebview extends Webview<PuppeteerProvider> {
  PuppeteerWebview({
    required final PuppeteerProvider provider,
  }) : super(provider: provider);

  Page? page;

  @override
  Future<void> initialize() async {
    page = await provider.context!.newPage();

    await page!.setUserAgent(HttpUtils.userAgent);

    await page!.setRequestInterception(true);
    page!.onRequest.listen((final Request request) {
      request.continueRequest(headers: headers);
    });

    await super.initialize();
  }

  @override
  Future<void> open(final String url, final WebviewWaitUntil waitUntil) async {
    beforeMethod();

    final Until? until;

    switch (waitUntil) {
      case WebviewWaitUntil.none:
        until = null;
        break;

      case WebviewWaitUntil.load:
        until = Until.load;
        break;

      case WebviewWaitUntil.domContentLoaded:
        until = Until.domContentLoaded;
        break;
    }

    await page!.goto(url, wait: until);
  }

  @override
  Future<dynamic> evalJavascript(final String code) async {
    beforeMethod();

    return page!.evaluate(code);
  }

  @override
  Future<String?> getHtml() async {
    beforeMethod();

    final dynamic result =
        await page!.evaluate('() => document.documentElement.outerHTML');

    return result is String ? result : null;
  }

  @override
  Future<Map<String, String>> getCookies(final String url) async {
    beforeMethod();

    final Uri uri = Uri.parse(url);
    final String domain = uri.authority;
    final List<Cookie> cookies = await page!.cookies();

    return cookies
        .where(
          (final Cookie x) => x.domain == domain || '.${x.domain}' == domain,
        )
        .toList()
        .asMap()
        .map(
          (final int i, final Cookie x) =>
              MapEntry<String, String>(x.name, x.value),
        );
  }

  @override
  Future<void> deleteCookie(final String url, final String name) async {
    beforeMethod();

    final Uri uri = Uri.parse(url);
    final String domain = uri.authority;
    final List<Cookie> cookies = await page!.cookies();

    await Future.wait(
      cookies.where((final Cookie x) => x.domain == domain).toList().map(
            (final Cookie x) => page!.deleteCookie(
              x.name,
              domain: domain,
            ),
          ),
    );
  }

  @override
  Future<void> clearAllCookies() async {
    beforeMethod();

    await Future.wait(
      (await page!.cookies())
          .map((final Cookie x) => page!.deleteCookie(x.name)),
    );
  }

  @override
  Future<void> dispose() async {
    await page?.close();
    page = null;

    await super.dispose();
  }
}
