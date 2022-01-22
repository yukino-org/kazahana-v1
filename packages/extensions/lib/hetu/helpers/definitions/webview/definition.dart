import './binding.dart';
import '../../model.dart';

final HetuHelperClass hWebviewClass = HetuHelperClass(
  definition: WebviewClassBinding(),
  declaration: '''
external class Webview {
  /// boolean
  get disposed;

  /// (string, 'none' | 'load' | 'domContentLoaded') => DartFuture<void>
  fun open(url, waitUntil);

  /// () => DartFuture<string?>
  fun getHtml();

  /// (string)<T = any> => DartFuture<T>
  fun evalJavascript(code);

  /// (string) => DartFuture<Map<string, string>>
  fun getCookies(url);

  /// (string, string) => DartFuture<void>
  fun deleteCookie(url, name);

  /// () => DartFuture<void>
  fun clearAllCookies();

  /// (Map<string, string?>) => void
  fun addExtraHeaders(headers);

  /// () => void
  fun removeAllExtraHeaders();
  
  /// In the [check] function, returning `true` = Needs to be bypassed | `false` = Has been bypassed
  /// ((string) => bool) => DartFuture<void>
  fun tryBypassBrowserVerification(check);

  /// () => DartFuture<void>
  fun tryBypassCloudfareBrowserVerification();

  /// () => DartFuture<void>
  fun dispose();

  /// () => DartFuture<Webview>
  static fun create();
}
      '''
      .trim(),
);
