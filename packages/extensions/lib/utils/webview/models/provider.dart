import 'package:meta/meta.dart';
import './webview.dart';

class WebviewProviderOptions {
  const WebviewProviderOptions({
    final this.localChromiumPath,
  });

  final String? localChromiumPath;
}

abstract class WebviewProvider<T extends WebviewProvider<T>> {
  bool ready = false;
  bool disposed = false;

  @mustCallSuper
  Future<void> initialize(final WebviewProviderOptions options) async {
    ready = true;
  }

  Future<Webview<T>> create();

  @mustCallSuper
  Future<void> dispose() async {
    disposed = true;
  }
}
