import 'dart:async';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import './webview.dart';
import '../../models/provider.dart';

class FlutterWebviewProvider extends WebviewProvider<FlutterWebviewProvider> {
  CookieManager? cookies = CookieManager.instance();

  @override
  Future<FlutterWebviewWebview> create() async {
    final FlutterWebviewWebview webview = FlutterWebviewWebview(provider: this);
    await webview.initialize();
    return webview;
  }

  @override
  Future<void> dispose() async {
    cookies = null;

    await super.dispose();
  }

  static bool isSupported() => Platform.isAndroid || Platform.isIOS;
}
