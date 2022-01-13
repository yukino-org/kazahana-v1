import './models/webview.dart';

/// `true` = Needs to be bypassed | `false` = Has been bypassed
typedef HtmlBypassBrowserCheck = bool Function(String);

abstract class WebviewUtils {
  static bool isCloudflareVerification(final String html) {
    final String htmlLwr = html.toLowerCase();

    return <bool>[
      htmlLwr.contains('id="cf-wrapper"'),
      RegExp('class=".*(cf-browser-verification|cf-im-under-attack).*"')
          .hasMatch(htmlLwr),
    ].contains(true);
  }

  static Future<bool> tryBypassBrowserVerification(
    final Webview<dynamic> webview,
    final HtmlBypassBrowserCheck check,
  ) async {
    final List<Duration> checkIntervals = <Duration>[
      Duration.zero,
      ...List<Duration>.generate(
        5,
        (final int i) => Duration(seconds: i + 1),
      ).reversed,
    ];

    for (final Duration i in checkIntervals) {
      await Future<void>.delayed(i);

      final String? html = await webview.getHtml();
      if (html != null && !check(html)) {
        return true;
      }
    }

    return false;
  }
}
