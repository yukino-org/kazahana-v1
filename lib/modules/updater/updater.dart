import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:version/version.dart';
import './android/apk.dart';
import './linux/appimage.dart';
import './windows/exe.dart';
import '../../config/app.dart';
import '../helpers/logger.dart';
import '../state/eventer.dart';

class UpdateInfo {
  UpdateInfo({
    required final this.release,
    required final this.version,
    required final this.path,
    required final this.size,
    required final this.date,
  });

  final String release;
  final Version version;
  final String path;
  final int size;
  final DateTime date;
}

enum UpdateTypes {
  beta,
  stable,
}

extension UpdateTypesUtils on UpdateTypes {
  String get type => toString().split('.').last;
}

enum UpdaterEvents {
  starting,
  downloading,
  extracting,
}

class UpdaterEvent {
  UpdaterEvent(this.event, [final this.data]);

  final UpdaterEvents event;
  final dynamic data;
}

class InstallResponse {
  InstallResponse({
    required final this.exit,
    final this.beforeExit,
  });

  final bool exit;
  final Future<void> Function()? beforeExit;
}

abstract class PlatformUpdater {
  final Eventer<UpdaterEvent> progress = Eventer<UpdaterEvent>();

  Future<List<UpdateInfo>> getUpdates() async {
    try {
      final Version currentVersion = Version.parse(Config.version);

      final http.Response res = await http.get(Uri.parse(Config.releasesURL));
      final List<Map<dynamic, dynamic>> releases =
          (json.decode(res.body) as List<dynamic>)
              .cast<Map<dynamic, dynamic>>();

      Version foundVersion = currentVersion;
      List<UpdateInfo> updates = <UpdateInfo>[];

      for (final Map<dynamic, dynamic> x in releases) {
        final Version version = Version.parse(
          (x['tag_name'] as String).replaceFirst(RegExp('^v'), ''),
        );

        if (version > foundVersion) {
          final String release = x['name'] as String;
          final DateTime date = DateTime.parse(x['published_at'] as String);

          foundVersion = version;
          updates = (x['assets'] as List<dynamic>)
              .cast<Map<dynamic, dynamic>>()
              .map(
                (final Map<dynamic, dynamic> y) => UpdateInfo(
                  release: release,
                  version: foundVersion,
                  path: y['browser_download_url'] as String,
                  size: y['size'] as int,
                  date: date,
                ),
              )
              .toList();
        }
      }

      return updates;
    } catch (err, stack) {
      Logger.of('PlatformUpdater').error('"getUpdates" failed: $err', stack);

      return <UpdateInfo>[];
    }
  }

  UpdateInfo? filterUpdate(final List<UpdateInfo> updates);

  Future<InstallResponse> install(final UpdateInfo update);
}

typedef PlatformUpdaterValidate = bool Function();

abstract class Updater {
  static final Map<PlatformUpdaterValidate, PlatformUpdater Function()>
      matchers = <PlatformUpdaterValidate, PlatformUpdater Function()>{
    WindowsExeUpdater.isSupported: () => WindowsExeUpdater(),
    LinuxAppImageUpdater.isSupported: () => LinuxAppImageUpdater(),
    AndroidApkUpdater.isSupported: () => AndroidApkUpdater(),
  };

  static PlatformUpdater? getUpdater() => matchers.entries
      .firstWhereOrNull(
        (
          final MapEntry<PlatformUpdaterValidate, PlatformUpdater Function()> x,
        ) =>
            x.key(),
      )
      ?.value();
}
