import 'dart:io';
import 'package:puppeteer/puppeteer.dart';
import './chrome_finder/chrome_finder.dart';
import './webview.dart';
import '../../models/provider.dart';

class PuppeteerProvider extends WebviewProvider<PuppeteerProvider> {
  Browser? browser;
  BrowserContext? context;
  String? chromePath;

  @override
  Future<void> initialize(final WebviewProviderOptions options) async {
    final String? foundPath = await ChromeFinder.find();

    final List<Future<bool> Function()> tasks = <Future<bool> Function()>[
      if (foundPath != null)
        () async {
          await _launch(foundPath);
          return true;
        },
      () async {
        final RevisionInfo revision =
            await downloadChrome(cachePath: options.localChromiumPath);
        await _launch(revision.executablePath);
        return true;
      }
    ];

    for (final Future<bool> Function() x in tasks) {
      try {
        await x();
        break;
      } catch (_) {}
    }

    await super.initialize(options);
  }

  Future<void> _launch(final String executablePath) async {
    browser = await puppeteer.launch(
      executablePath: executablePath,
      args: <String>[
        '--single-process',
        '--no-zygote',
        '--no-sandbox',
      ],
    );

    context = await browser!.createIncognitoBrowserContext();

    chromePath = executablePath;
  }

  @override
  Future<PuppeteerWebview> create() async {
    final PuppeteerWebview webview = PuppeteerWebview(provider: this);
    await webview.initialize();
    return webview;
  }

  Future<void> _disposePages(final List<Page> pages) => Future.wait(
        pages.map((final Page x) => x.close()),
      );

  @override
  Future<void> dispose() async {
    if (browser != null) {
      await _disposePages(await context!.pages);
      context!.close();
      context = null;

      await _disposePages(await browser!.pages);
      await browser!.close();
      browser = null;
    }

    await super.dispose();
  }

  static bool isSupported() =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}
