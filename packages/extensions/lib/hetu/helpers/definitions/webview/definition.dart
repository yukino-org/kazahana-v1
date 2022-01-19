import './binding.dart';
import '../../model.dart';

final HetuHelperClass hWebviewClass = HetuHelperClass(
  definition: WebviewClassBinding(),
  declaration: '''
external class Webview {
  final disposed;

  fun open(url, waitUntil);
  fun getHtml();
  fun evalJavascript(code);
  fun getCookies(url);
  fun deleteCookie(url, name);
  fun clearAllCookies();
  fun tryBypassBrowserVerification(check);
  fun tryBypassCloudfareBrowserVerification();
  fun dispose();

  static fun create();
}
      '''
      .trim(),
);
