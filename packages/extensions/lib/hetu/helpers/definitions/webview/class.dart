import 'package:hetu_script/values.dart';
import '../../../../utils/html_dom/html_dom.dart';
import '../../../../utils/html_dom/utils.dart';

export '../../../../utils/html_dom/html_dom.dart' show HtmlDOMTab;

Future<HtmlDOMTab> createWebview() => HtmlDOMManager.provider.create();

extension Webview on HtmlDOMTab {
  Future<bool> tryBypassBrowserChecks(final HTFunction check) =>
      HtmlDOMUtils.tryBypassBrowserChecks(
        this,
        (final String html) =>
            check.call(positionalArgs: <dynamic>[html]) as bool,
      );

  Future<bool> tryBypassCloudflareCheck() =>
      HtmlDOMUtils.tryBypassBrowserChecks(this, HtmlDOMUtils.checkCloudflare);
}
