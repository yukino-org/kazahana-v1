import 'package:flutter/material.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/utils.dart';
import '../../../../modules/database/database.dart';
import '../../../../modules/helpers/ui.dart';
import '../../../../modules/tenka.dart';
import '../../../../modules/translator/translator.dart';

class ExtensionsPage extends StatefulWidget {
  const ExtensionsPage({
    final Key? key,
  }) : super(key: key);

  @override
  _ExtensionsPageState createState() => _ExtensionsPageState();
}

class _ExtensionsPageState extends State<ExtensionsPage> {
  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Translator.t.extensions(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: Theme.of(context).textTheme.headline6?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: remToPx(0.5),
          ),
          ...TenkaManager.repository.store.modules.values.map(
            (final TenkaMetadata module) {
              final bool installed =
                  TenkaManager.repository.isInstalled(module);

              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () async {
                    await showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      pageBuilder: (
                        final BuildContext context,
                        final Animation<double> a1,
                        final Animation<double> a2,
                      ) =>
                          SafeArea(
                        child: Dialog(
                          child: _ExtensionPopup(module: module),
                        ),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: remToPx(0.6),
                      vertical: remToPx(0.5),
                    ),
                    child: Row(
                      children: <Widget>[
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.9),
                            borderRadius: BorderRadiusDirectional.circular(
                              remToPx(0.2),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: remToPx(0.4),
                              vertical: remToPx(0.1),
                            ),
                            child: Image.network(
                              TenkaManager.resolveTenkaCloudDSURL(
                                module.thumbnail as TenkaCloudDS,
                              ),
                              width: remToPx(1.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: remToPx(0.75),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: <InlineSpan>[
                                TextSpan(
                                  text: '${module.name}\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextSpan(
                                  children: ListUtils.insertBetween(
                                    <InlineSpan>[
                                      TextSpan(
                                        text: StringUtils.capitalize(
                                          module.type.name,
                                        ),
                                      ),
                                      if (module.nsfw)
                                        TextSpan(
                                          text: Translator.t.nsfw(),
                                          style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                    const TextSpan(text: ' — '),
                                  ),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (installed)
                          Padding(
                            padding: EdgeInsets.only(
                              left: remToPx(0.75),
                              right: remToPx(0.25),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.green[400],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
}

enum ModuleState {
  install,
  installed,
  installing,
  uninstalling,
}

class _ExtensionPopup extends StatefulWidget {
  const _ExtensionPopup({
    required final this.module,
    final Key? key,
  }) : super(key: key);

  final TenkaMetadata module;

  @override
  _ExtensionPopupState createState() => _ExtensionPopupState();
}

class _ExtensionPopupState extends State<_ExtensionPopup> {
  late ModuleState status = TenkaManager.repository.isInstalled(widget.module)
      ? ModuleState.installed
      : ModuleState.install;

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: remToPx(1.2),
            vertical: remToPx(0.8),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width > ResponsiveSizes.sm
                ? ResponsiveSizes.sm.toDouble()
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(remToPx(0.2)),
                      child: Container(
                        height: remToPx(2.5),
                        padding: EdgeInsets.all(remToPx(0.3)),
                        color: Colors.black.withOpacity(0.9),
                        child: Image.network(
                          TenkaManager.resolveTenkaCloudDSURL(
                            widget.module.thumbnail as TenkaCloudDS,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: remToPx(1),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.module.name,
                            style: FunctionUtils.withValue(
                              Theme.of(context).textTheme.headline6,
                              (final TextStyle? style) => style?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (widget.module.nsfw)
                            TextSpan(
                              text: '  (${Translator.t.nsfw()})',
                              style: FunctionUtils.withValue(
                                Theme.of(context).textTheme.bodyText2,
                                (final TextStyle? style) => style?.copyWith(
                                  color: Colors.red.shade400,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          TextSpan(
                            text:
                                '\n${Translator.t.by()} ${widget.module.author}',
                          ),
                          // TODO: fix this
                          // TextSpan(
                          //   text:
                          //       '\n${Translator.t.language()}: ${widget.module.defaultLocale.toPrettyString()}',
                          // ),
                          TextSpan(
                            text:
                                '\n${Translator.t.version()}: ${widget.module.version.toString()}',
                          ),
                        ],
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: remToPx(0.5),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: Theme.of(context).textTheme.button?.fontSize,
                        ),
                        label: Text(Translator.t.cancel()),
                      ),
                    ),
                    SizedBox(
                      width: remToPx(0.5),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: <ModuleState>[
                          ModuleState.install,
                          ModuleState.installed,
                        ].contains(status)
                            ? () async {
                                if (status == ModuleState.installed) {
                                  setState(() {
                                    status = ModuleState.uninstalling;
                                  });

                                  await TenkaManager.repository
                                      .uninstall(widget.module);

                                  if (mounted) {
                                    setState(() {
                                      status = ModuleState.install;
                                    });
                                  }
                                } else if (status == ModuleState.install) {
                                  setState(() {
                                    status = ModuleState.installing;
                                  });

                                  await TenkaManager.repository
                                      .install(widget.module);

                                  if (mounted) {
                                    setState(() {
                                      status = ModuleState.installed;
                                    });

                                    final CachedPreferencesSchema preferences =
                                        CachedPreferencesBox.get();
                                    if (preferences
                                            .lastSelectedSearch?.isEmpty ??
                                        true) {
                                      final TenkaMetadata? module = TenkaManager
                                          .repository
                                          .installed[widget.module.id];

                                      if (module != null) {
                                        preferences
                                            .lastSelectedSearch = (preferences
                                                    .lastSelectedSearch ??
                                                const LastSelectedSearchPlugin())
                                            .copyWith(
                                          lastSelectedType: widget.module.type,
                                          lastSelectedAnimePlugin:
                                              widget.module.type ==
                                                      TenkaType.anime
                                                  ? module.id
                                                  : null,
                                          lastSelectedMangaPlugin:
                                              widget.module.type ==
                                                      TenkaType.manga
                                                  ? module.id
                                                  : null,
                                        );
                                        await CachedPreferencesBox.save(
                                          preferences,
                                        );
                                      }
                                    }
                                  }
                                }
                              }
                            : null,
                        icon: Icon(
                          <ModuleState>[
                            ModuleState.install,
                            ModuleState.installing,
                          ].contains(status)
                              ? Icons.add
                              : Icons.delete,
                          size: Theme.of(context).textTheme.button?.fontSize,
                        ),
                        label: Text(
                          status == ModuleState.install
                              ? Translator.t.install()
                              : status == ModuleState.installed
                                  ? Translator.t.uninstall()
                                  : status == ModuleState.installing
                                      ? Translator.t.installing()
                                      : Translator.t.uninstalling(),
                        ),
                        style: TextButton.styleFrom(
                          side: BorderSide.none,
                          primary: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
