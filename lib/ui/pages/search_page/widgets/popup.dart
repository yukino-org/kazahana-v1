import 'package:tenka/tenka.dart';
import 'package:flutter/material.dart';
import 'package:utilx/utils.dart';
import '../../../../config/defaults.dart';
import '../../../../modules/tenka.dart';
import '../../../../modules/helpers/ui.dart';
import '../../../../modules/translator/translator.dart';
import '../../../models/view.dart';
import '../controller.dart';

class SearchExtensionsPopUp extends StatefulWidget {
  const SearchExtensionsPopUp({
    required final this.controller,
    final Key? key,
  }) : super(key: key);

  final SearchPageController controller;

  @override
  _SearchExtensionsPopUpState createState() => _SearchExtensionsPopUpState();
}

class _SearchExtensionsPopUpState extends State<SearchExtensionsPopUp> {
  late TenkaType activeType =
      widget.controller.currentModule?.type ?? TenkaType.anime;

  Widget buildListTile({
    required final BuildContext context,
    required final TenkaMetadata module,
  }) =>
      Material(
        type: MaterialType.transparency,
        child: RadioListTile<String>(
          title: Text(module.name),
          value: module.id,
          groupValue: widget.controller.currentModule?.id,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (final String? val) async {
            if (val == module.id) {
              await widget.controller.setCurrentModule(module);
            }
          },
        ),
      );

  Widget buildList(
    final BuildContext context,
    final TenkaType type,
  ) {
    final List<TenkaMetadata> filtered = TenkaManager
        .repository.installed.values
        .where((final TenkaMetadata x) => x.type == type)
        .toList();
    if (filtered.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: filtered
            .map(
              (final TenkaMetadata x) => buildListTile(
                context: context,
                module: x,
              ),
            )
            .toList(),
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: remToPx(1),
          right: remToPx(1),
          top: remToPx(1.1),
          bottom: remToPx(0.5),
        ),
        child: Text(
          Translator.t.nothingWasFoundHere(),
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Theme.of(context).textTheme.caption?.color,
              ),
        ),
      ),
    );
  }

  Widget buildTitle(final BuildContext context) {
    final bool isLarge = MediaQuery.of(context).size.width > ResponsiveSizes.xs;

    final Widget switcher = Row(
      mainAxisSize: isLarge ? MainAxisSize.min : MainAxisSize.max,
      children: <TenkaType>[
        TenkaType.anime,
        TenkaType.manga,
      ].map((final TenkaType x) {
        final bool isCurrent = x == activeType;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: remToPx(0.1),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: () {
                setState(() {
                  activeType = x;
                });
              },
              borderRadius: BorderRadius.circular(4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isCurrent
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: remToPx(0.5),
                    vertical: remToPx(0.2),
                  ),
                  child: Text(
                    StringUtils.capitalize(x.name),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: isCurrent ? Colors.white : null,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );

    if (isLarge) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            Translator.t.selectPlugin(),
            style: Theme.of(context).textTheme.headline6,
          ),
          switcher,
        ],
      );
    }

    return Column(
      children: <Widget>[
        Text(
          Translator.t.selectPlugin(),
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: remToPx(0.5)),
        switcher,
      ],
    );
  }

  @override
  Widget build(final BuildContext context) => AnimatedSwitcher(
        duration: Defaults.animationsFast,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        layoutBuilder: (
          final Widget? currentChild,
          final List<Widget> previousChildren,
        ) =>
            Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        ),
        child: View<SearchPageController>(
          key: ValueKey<TenkaType>(activeType),
          controller: widget.controller,
          builder: (
            final BuildContext context,
            final SearchPageController controller,
          ) =>
              Dialog(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: remToPx(0.5),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: remToPx(1)),
                      child: buildTitle(context),
                    ),
                    SizedBox(height: remToPx(0.3)),
                    buildList(context, activeType),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: remToPx(0.7),
                        ),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: remToPx(0.6),
                                vertical: remToPx(0.3),
                              ),
                              child: Text(
                                Translator.t.close(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
