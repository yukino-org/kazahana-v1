import 'dart:async';
import 'package:meta/meta.dart';
import './provider.dart';

enum WebviewWaitUntil {
  none,
  load,
  domContentLoaded,
}

abstract class Webview<T extends WebviewProvider<T>> {
  Webview({
    required final this.provider,
  });

  final T provider;

  final Map<String, String> headers = <String, String>{};

  bool ready = false;
  bool disposed = false;
  int lastUsed = DateTime.now().millisecondsSinceEpoch;

  late final Timer timer =
      Timer.periodic(expireCheckDuration, (final Timer timer) async {
    if (expired && !disposed) {
      await dispose();
      timer.cancel();
      disposed = true;
    }
  });

  void beforeMethod() {
    if (disposed) {
      throw StateError('DOM has been disposed');
    }

    lastUsed = DateTime.now().microsecondsSinceEpoch;
  }

  @mustCallSuper
  Future<void> initialize() async {
    ready = true;
  }

  Future<void> open(final String url, final WebviewWaitUntil waitUntil);

  Future<dynamic> evalJavascript(final String code);

  Future<Map<String, String>> getCookies(final String url);

  Future<void> deleteCookie(final String url, final String name);

  Future<void> clearAllCookies();

  Future<String?> getHtml();

  void addExtraHeaders(final Map<String, String?> headers) {
    beforeMethod();

    headers.forEach((final String key, final String? value) {
      if (value is String) {
        this.headers[key] = value;
      } else {
        this.headers.remove(key);
      }
    });
  }

  void removeAllExtraHeaders() {
    headers.clear();
  }

  @mustCallSuper
  Future<void> dispose() async {
    if (!disposed) {
      timer.cancel();
      disposed = true;
    }
  }

  bool get expired =>
      DateTime.now().millisecondsSinceEpoch >
      (lastUsed + expireDuration.inMilliseconds);

  static const Duration expireDuration = Duration(minutes: 2);
  static const Duration expireCheckDuration = Duration(minutes: 1);
}
