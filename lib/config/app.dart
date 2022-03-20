import 'dart:convert';
import 'package:flutter/services.dart';

abstract class Config {
  static const String name = 'Kazahana';
  static const String protocol = 'kazahana';
  static late String code;
  static late String version;

  static bool ready = false;

  static Future<void> initialize() async {
    final String meta = await rootBundle.loadString('assets/data/meta.json');
    final Map<dynamic, dynamic> parsed =
        json.decode(meta) as Map<dynamic, dynamic>;

    code = parsed['code'] as String;
    version = parsed['version'] as String;

    ready = true;
  }

  static const String repoAuthor = 'yukino-app';
  static const String repoName = 'kazahana';

  static const String storeURL =
      'https://raw.githubusercontent.com/$repoAuthor/extensions-store/dist/extensions.json';

  static const String releasesURL =
      'https://api.github.com/repos/$repoAuthor/$repoName/releases?per_page=20';

  static const String gitHubURL = 'https://github.com/$repoAuthor/$repoName';
  static const String gitHubIssuesURL = '$gitHubURL/issues';
  static const String websiteURL = 'https://yukino-org.github.io';
  static const String discordURL = 'https://yukino-org.github.io/discord';
  static const String wikiURL = 'https://yukino-org.github.io/wiki';
  static const String patreonURL = 'https://yukino-org.github.io/patreon';
}
