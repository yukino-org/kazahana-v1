import 'package:utilx/utils.dart';
import '../anilist.dart';

class AniListUserInfo {
  AniListUserInfo({
    required final this.id,
    required final this.name,
    required final this.avatarMedium,
  });

  factory AniListUserInfo.fromJson(final Map<dynamic, dynamic> json) =>
      AniListUserInfo(
        id: json['id'] as int,
        name: json['name'] as String,
        avatarMedium: MapUtils.get<String>(json, <dynamic>['avatar', 'medium']),
      );

  int id;
  String name;
  String avatarMedium;

  static AniListUserInfo? _cachedUser;

  static Future<AniListUserInfo> getUserInfo({
    final bool force = false,
  }) async {
    if (!force && _cachedUser != null) {
      return _cachedUser!;
    }

    const String query = '''
query {
  Viewer {
    id
    name
    avatar {
      medium
    }
  }
}
  ''';

    final Map<dynamic, dynamic> res = await AnilistManager.request(
      RequestBody(
        query: query,
      ),
    ) as Map<dynamic, dynamic>;

    final AniListUserInfo info = AniListUserInfo.fromJson(
      MapUtils.get<Map<dynamic, dynamic>>(res, <dynamic>['data', 'Viewer']),
    );

    _cachedUser = info;
    return info;
  }
}
