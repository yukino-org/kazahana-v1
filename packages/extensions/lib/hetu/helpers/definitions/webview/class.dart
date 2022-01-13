import '../../../../utils/webview/webview.dart';

export '../../../../utils/webview/webview.dart' show WebviewWaitUntil;

class HetuWebview {
  const HetuWebview(this.instance);

  final Webview<dynamic> instance;

  Future<void> open(final String url, final WebviewWaitUntil waitUntil) =>
      instance.open(url, waitUntil);

  Future<dynamic> evalJavascript(final String code) =>
      instance.evalJavascript(code);

  Future<Map<String, String>> getCookies(final String url) =>
      instance.getCookies(url);

  Future<void> deleteCookie(final String url, final String name) =>
      instance.deleteCookie(url, name);

  Future<void> clearAllCookies() => instance.clearAllCookies();

  Future<String?> getHtml() => instance.getHtml();

  Future<void> dispose() => instance.dispose();

  bool get disposed => instance.disposed;

  static Future<HetuWebview> createWebview() async {
    final Webview<dynamic> instance = await WebviewManager.provider.create();

    return HetuWebview(instance);
  }
}
