import '../../../../utils/webview/webview.dart';

export '../../../../utils/webview/webview.dart';

Future<Webview<dynamic>> createWebview() => WebviewManager.provider.create();
