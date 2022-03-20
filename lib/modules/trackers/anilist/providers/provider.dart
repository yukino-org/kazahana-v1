import 'package:flutter/material.dart';
import 'package:tenka/tenka.dart';
import '../../../database/database.dart';
import '../../../helpers/assets.dart';
import '../../../translator/translator.dart';
import '../../provider.dart';
import '../anilist.dart';

abstract class AniListProvider {
  static final TrackerProvider<AnimeProgress> anime =
      TrackerProvider<AnimeProgress>(
    name: Translator.t.anilist(),
    image: Assets.anilistLogo,
    getComputed: _getComputed(TenkaType.anime),
    getComputables: _getComputables(TenkaType.anime),
    resolveComputed: _resolveComputable(TenkaType.anime),
    updateComputed: (
      final ResolvedTrackerItem media,
      final AnimeProgress progress,
    ) async {
      final AniListMediaList info = media.info as AniListMediaList;
      final AniListMediaListStatus status = info.media.episodes != null &&
              progress.episodes >= info.media.episodes!
          ? AniListMediaListStatus.completed
          : AniListMediaListStatus.current;

      final int episodes = progress.episodes;

      final int repeat = progress.episodes == 1 && info.progress > 1
          ? info.repeat + 1
          : info.repeat;

      int changes = 0;
      final List<List<dynamic>> changables = <List<dynamic>>[
        <dynamic>[info.status, status],
        <dynamic>[info.progress, episodes],
        <dynamic>[info.repeat, repeat],
      ];

      for (final List<dynamic> item in changables) {
        if (item.first != item.last) {
          changes += 1;
        }
      }

      if (changes > 0) {
        await info.update(
          status: status,
          progress: episodes,
          progressVolumes: null,
          score: null,
          repeat: repeat,
        );

        _cache[info.media.id] = info;
        onItemUpdateChangeNotifier.dispatch(media);
      }
    },
    isLoggedIn: _isLoggedIn,
    isEnabled: _isEnabled(TenkaType.anime),
    setEnabled: _setEnabled(TenkaType.anime),
    getDetailedPage: _getDetailedPage,
    isItemSameKind: _isItemSameKind,
  );

  static final TrackerProvider<MangaProgress> manga =
      TrackerProvider<MangaProgress>(
    name: Translator.t.anilist(),
    image: Assets.anilistLogo,
    getComputed: _getComputed(TenkaType.manga),
    getComputables: _getComputables(TenkaType.manga),
    resolveComputed: _resolveComputable(TenkaType.manga),
    updateComputed: (
      final ResolvedTrackerItem media,
      final MangaProgress progress,
    ) async {
      final AniListMediaList info = media.info as AniListMediaList;
      final AniListMediaListStatus status = info.media.chapters != null &&
              progress.chapters >= info.media.chapters!
          ? AniListMediaListStatus.completed
          : AniListMediaListStatus.current;

      final int chapters = progress.chapters;
      final int? volumes = progress.volume ?? info.progressVolumes;

      final int repeat = progress.chapters == 1 && info.progress > 1
          ? info.repeat + 1
          : info.repeat;

      int changes = 0;
      final List<List<dynamic>> changables = <List<dynamic>>[
        <dynamic>[info.status, status],
        <dynamic>[info.progress, chapters],
        <dynamic>[info.progressVolumes, volumes],
        <dynamic>[info.repeat, repeat],
      ];

      for (final List<dynamic> item in changables) {
        if (item.first != item.last) {
          changes += 1;
        }
      }

      if (changes > 0) {
        await info.update(
          status: status,
          progress: chapters,
          progressVolumes: volumes,
          score: null,
          repeat: repeat,
        );

        _cache[info.media.id] = info;
        onItemUpdateChangeNotifier.dispatch(media);
      }
    },
    isLoggedIn: _isLoggedIn,
    isEnabled: _isEnabled(TenkaType.manga),
    setEnabled: _setEnabled(TenkaType.manga),
    getDetailedPage: _getDetailedPage,
    isItemSameKind: _isItemSameKind,
  );

  static final Map<int, AniListMediaList> _cache = <int, AniListMediaList>{};

  static final bool Function() _isLoggedIn = AnilistManager.auth.isValidToken;

  static Future<ResolvedTrackerItem?> Function(
    String title,
    String plugin, {
    bool force,
  }) _getComputed(
    final TenkaType mediaType,
  ) =>
      (
        final String title,
        final String plugin, {
        final bool force = false,
      }) async {
        final CacheSchema? cache = CacheBox.get('anilist-$title-$plugin');

        try {
          if (!force && cache != null) {
            final AniListUserInfo user = await AniListUserInfo.getUserInfo();

            final AniListMediaList mediaList = _cache[cache.value] ??
                await AniListMediaList.getFromMediaId(
                  cache.value as int,
                  user.id,
                );

            return ResolvedTrackerItem(
              title: mediaList.media.titleUserPreferred,
              image: mediaList.media.coverImageMedium,
              info: mediaList,
            );
          }
        } catch (_) {}

        final List<AniListMedia> media =
            await AniListMedia.search(title, mediaType, 0, 1);
        if (media.isNotEmpty) {
          final AniListUserInfo user = await AniListUserInfo.getUserInfo();

          final AniListMediaList mediaList =
              await AniListMediaList.getFromMediaId(media.first.id, user.id);

          await CacheBox.saveKV('anilist-$title-$plugin', media.first.id, 0);

          return ResolvedTrackerItem(
            title: mediaList.media.titleUserPreferred,
            image: mediaList.media.coverImageMedium,
            info: mediaList,
          );
        }

        return null;
      };

  static Future<List<ResolvableTrackerItem>> Function(String title)
      _getComputables(
    final TenkaType mediaType,
  ) =>
          (final String title) async {
            final List<AniListMedia> media =
                await AniListMedia.search(title, mediaType);
            return media
                .map(
                  (final AniListMedia x) => ResolvableTrackerItem(
                    id: x.id.toString(),
                    title: x.titleUserPreferred,
                    image: x.coverImageMedium,
                  ),
                )
                .toList();
          };

  static Future<ResolvedTrackerItem> Function(
    String title,
    String plugin,
    ResolvableTrackerItem item,
  ) _resolveComputable(
    final TenkaType mediaType,
  ) =>
      (
        final String title,
        final String plugin,
        final ResolvableTrackerItem item,
      ) async {
        final AniListUserInfo user = await AniListUserInfo.getUserInfo();

        final AniListMediaList mediaList =
            await AniListMediaList.getFromMediaId(int.parse(item.id), user.id);

        await CacheBox.saveKV('anilist-$title-$plugin', mediaList.media.id, 0);

        _cache[mediaList.media.id] = mediaList;

        return ResolvedTrackerItem(
          title: mediaList.media.titleUserPreferred,
          image: mediaList.media.coverImageMedium,
          info: mediaList,
        );
      };

  static bool Function(String, String) _isEnabled(
    final TenkaType mediaType,
  ) =>
      (final String title, final String plugin) =>
          CacheBox.get('anilist-${mediaType.name}-$title-$plugin-disabled') ==
          null;

  static Future<void> Function(String, String, bool) _setEnabled(
    final TenkaType mediaType,
  ) =>

      // ignore: avoid_positional_boolean_parameters
      (final String title, final String plugin, final bool isEnabled) async {
        final String key = 'anilist-${mediaType.name}-$title-$plugin-disabled';
        isEnabled ? CacheBox.delete(key) : await CacheBox.saveKV(key, null, 0);
      };

  static Widget _getDetailedPage(
    final BuildContext context,
    final ResolvedTrackerItem item,
  ) =>
      (item.info as AniListMediaList).getDetailedPage(
        context,
        Navigator.of(context).pop,
      );

  static bool _isItemSameKind(
    final ResolvedTrackerItem current,
    final ResolvedTrackerItem unknown,
  ) =>
      current.info is AniListMediaList &&
      unknown.info is AniListMediaList &&
      (unknown.info as AniListMediaList).media.id ==
          (current.info as AniListMediaList).media.id;
}
