import 'dart:io';
import 'package:tenka/tenka.dart';
import '../database/database.dart';
import '../state/eventer.dart';

abstract class AppState {
  static ReactiveEventer<SettingsSchema>? _settings;

  static Future<void> initialize() async {
    // TODO: Fix this
    // _settings = ReactiveEventer<SettingsSchema>(SettingsBox.get())
    //   ..subscribe(
    //     (final SettingsSchema current, final SettingsSchema previous) {
    //       if (current.developers.ignoreBadHttpCertificate !=
    //           previous.developers.ignoreBadHttpCertificate) {
    //         TenkaRuntimeHttpClient.initialize(
    //           HttpClientOptions(
    //             ignoreSSLCertificate:
    //                 current.developers.ignoreBadHttpCertificate,
    //           ),
    //         );
    //       }
    //     },
    //   );
  }

  static ReactiveEventer<SettingsSchema> get settings => _settings!;

  static bool get loaded => _settings != null;

  static bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;

  static bool get isMobile => Platform.isAndroid || Platform.isIOS;
}
