import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tenka/tenka.dart';
import '../../../modules/database/database.dart';
import '../../../modules/state/stateful_holder.dart';
import '../../../modules/tenka.dart';
import '../../../modules/translator/translator.dart';
import '../../models/controller.dart';
import '../../router.dart';
import '../anime_page/controller.dart';
import '../manga_page/controller.dart';

class SearchPageArguments {
  SearchPageArguments({
    final this.terms,
    final this.autoSearch,
    final this.moduleType,
    final this.moduleId,
  });

  factory SearchPageArguments.fromJson(final Map<String, String> json) =>
      SearchPageArguments(
        terms: json['terms'],
        autoSearch: json['autoSearch'] == 'true',
        moduleType: TenkaType.values.firstWhereOrNull(
          (final TenkaType x) => x.name == json['moduleType'],
        ),
        moduleId: json['moduleId'],
      );

  String? terms;
  bool? autoSearch;
  TenkaType? moduleType;
  String? moduleId;

  Map<String, String> toJson() {
    final Map<String, String> json = <String, String>{};

    if (terms != null) {
      json['terms'] = terms!;
    }

    if (autoSearch != null) {
      json['autoSearch'] = autoSearch.toString();
    }

    if (moduleType != null) {
      json['moduleType'] = moduleType!.name;
    }

    if (moduleId != null) {
      json['moduleId'] = moduleId!;
    }

    return json;
  }
}

extension PluginRoutes on TenkaType {
  String get route {
    switch (this) {
      case TenkaType.anime:
        return RouteNames.animePage;

      case TenkaType.manga:
        return RouteNames.mangaPage;
    }
  }

  Map<String, String> constructQuery({
    required final String plugin,
    required final String src,
  }) {
    switch (this) {
      case TenkaType.anime:
        return AnimePageArguments(src: src, plugin: plugin).toJson();

      case TenkaType.manga:
        return MangaPageArguments(src: src, plugin: plugin).toJson();
    }
  }
}

class SearchResult {
  const SearchResult({
    required final this.info,
    required final this.module,
  });

  final SearchInfo info;
  final TenkaMetadata module;
}

class SearchPageController extends Controller<SearchPageController> {
  SearchPageArguments? args;
  StatefulValueHolderWithError<List<SearchResult>?> results =
      StatefulValueHolderWithError<List<SearchResult>?>(null);

  final TextEditingController searchTextController = TextEditingController();
  TenkaMetadata? currentModule;

  @override
  Future<void> setup() async {
    final CachedPreferencesSchema preferences = CachedPreferencesBox.get();
    final TenkaType type =
        preferences.lastSelectedSearch?.lastSelectedType ?? TenkaType.anime;

    TenkaMetadata? module;
    switch (type) {
      case TenkaType.anime:
        module = TenkaManager.repository.installed[
                preferences.lastSelectedSearch?.lastSelectedAnimePlugin ??
                    ''] ??
            TenkaManager.repository.installed.values.firstWhereOrNull(
              (final TenkaMetadata x) => x.type == TenkaType.anime,
            );
        break;

      case TenkaType.manga:
        module = TenkaManager.repository.installed[
                preferences.lastSelectedSearch?.lastSelectedMangaPlugin ??
                    ''] ??
            TenkaManager.repository.installed.values.firstWhereOrNull(
              (final TenkaMetadata x) => x.type == TenkaType.manga,
            );
        break;
    }

    if (module != null) {
      setCurrentModule(module);
    }

    await super.setup();
  }

  @override
  Future<void> dispose() async {
    searchTextController.dispose();

    await super.dispose();
  }

  Future<void> onInitState(final BuildContext context) async {
    args = SearchPageArguments.fromJson(
      ParsedRouteInfo.fromSettings(ModalRoute.of(context)!.settings).params,
    );

    if (args?.terms != null) {
      searchTextController.value = TextEditingValue(text: args!.terms!);
    }

    if (args?.moduleType != null) {
      final TenkaMetadata? module =
          TenkaManager.repository.installed[args!.moduleId];

      if (module != null) {
        setCurrentModule(module);
      }
    }
  }

  Future<void> setCurrentModule(final TenkaMetadata? module) async {
    currentModule = module;

    if (module != null) {
      final CachedPreferencesSchema preferences = CachedPreferencesBox.get();
      preferences.lastSelectedSearch =
          (preferences.lastSelectedSearch ?? const LastSelectedSearchPlugin())
              .copyWith(
        lastSelectedType: module.type,
        lastSelectedAnimePlugin:
            module.type == TenkaType.anime ? module.id : null,
        lastSelectedMangaPlugin:
            module.type == TenkaType.manga ? module.id : null,
      );
      await CachedPreferencesBox.save(preferences);
    }

    reassemble();

    if (currentModule != null &&
        searchTextController.value.text.isNotEmpty &&
        (args?.autoSearch ?? false)) {
      args!.autoSearch = false;
      await search();
    }
  }

  Future<void> search() async {
    if (currentModule == null) {
      throw Exception('No plugin has been selected');
    }

    results.resolving(null);
    reassemble();

    try {
      final List<SearchInfo> searches;
      switch (currentModule!.type) {
        case TenkaType.anime:
          final AnimeExtractor extractor =
              await TenkaManager.getExtractor(currentModule!);

          searches = await extractor.search(
            searchTextController.text,
            Translator.t.locale,
          );
          break;

        case TenkaType.manga:
          final MangaExtractor extractor =
              await TenkaManager.getExtractor(currentModule!);

          searches = await extractor.search(
            searchTextController.text,
            Translator.t.locale,
          );
          break;
      }

      results.resolve(
        searches
            .map(
              (final SearchInfo x) => SearchResult(
                info: x,
                module: currentModule!,
              ),
            )
            .toList(),
      );
    } catch (err, stack) {
      results.failUnknown(null, err, stack);
    }

    reassemble();
  }
}
