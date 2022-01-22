import '../../../../utils/webview/webview.dart' as webview;

export '../../../../utils/webview/webview.dart' show WebviewWaitUntil;

class Webview {
  const Webview(this.instance);

  final webview.Webview<dynamic> instance;

  Future<void> open(
    final String url,
    final webview.WebviewWaitUntil waitUntil,
  ) =>
      instance.open(url, waitUntil);

  Future<dynamic> evalJavascript(final String code) =>
      instance.evalJavascript(code);

  Future<Map<String, String>> getCookies(final String url) =>
      instance.getCookies(url);

  Future<void> deleteCookie(final String url, final String name) =>
      instance.deleteCookie(url, name);

  Future<void> clearAllCookies() => instance.clearAllCookies();

  Future<String?> getHtml() => instance.getHtml();

  void addExtraHeaders(final Map<String, String?> headers) =>
      instance.addExtraHeaders(headers);

  void removeAllExtraHeaders() => instance.removeAllExtraHeaders();

  Future<void> dispose() => instance.dispose();

  bool get disposed => instance.disposed;

  static Future<Webview> createWebview() async {
    final webview.Webview<dynamic> instance =
        await webview.WebviewManager.provider.create();

    return Webview(instance);
  }
}
