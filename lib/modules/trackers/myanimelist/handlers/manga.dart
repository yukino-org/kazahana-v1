import 'dart:convert';
import 'package:utilx/utils.dart';
import '../myanimelist.dart';

class MyAnimeListSearchManga {
  MyAnimeListSearchManga({
    required final this.nodeId,
    required final this.title,
    required final this.mainPictureMedium,
    required final this.mainPictureLarge,
  });

  factory MyAnimeListSearchManga.fromJson(final Map<dynamic, dynamic> json) {
    final Map<dynamic, dynamic> node = json['node'] as Map<dynamic, dynamic>;

    return MyAnimeListSearchManga(
      nodeId: node['id'] as int,
      title: node['title'] as String,
      mainPictureMedium:
          MapUtils.get<String>(node, <dynamic>['main_picture', 'medium']),
      mainPictureLarge:
          MapUtils.get<String>(node, <dynamic>['main_picture', 'large']),
    );
  }

  final int nodeId;
  final String title;
  final String mainPictureMedium;
  final String mainPictureLarge;

  static Future<List<MyAnimeListSearchManga>> searchManga(
    final String terms,
  ) async {
    final String res = await MyAnimeListManager.request(
      MyAnimeListRequestMethods.get,
      '/manga?q=$terms&limit=10',
    );

    final Map<dynamic, dynamic> parsed =
        json.decode(res) as Map<dynamic, dynamic>;

    return (parsed['data'] as List<dynamic>)
        .cast<Map<dynamic, dynamic>>()
        .map(
          (final Map<dynamic, dynamic> x) => MyAnimeListSearchManga.fromJson(x),
        )
        .toList();
  }
}
