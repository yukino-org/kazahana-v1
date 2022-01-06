import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../../modules/app/state.dart';
import '../../../../../../modules/helpers/logger.dart';
import '../../../../../../modules/helpers/ui.dart';
import '../../../../../../modules/translator/translator.dart';
import '../controller.dart';

class SelectSourceWidget extends StatefulWidget {
  const SelectSourceWidget({
    required final this.controller,
    final Key? key,
  }) : super(key: key);

  final WatchPageController controller;

  @override
  _SelectSourceWidgetState createState() => _SelectSourceWidgetState();
}

class _SelectSourceWidgetState extends State<SelectSourceWidget> {
  @override
  Widget build(final BuildContext context) => Dialog(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: remToPx(0.8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: remToPx(1.1),
                ),
                child: Text(
                  Translator.t.selectSource(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
                height: remToPx(0.3),
              ),
              ...widget.controller.sources!
                  .asMap()
                  .map(
                    (final int i, final EpisodeSource x) =>
                        MapEntry<int, Widget>(
                      i,
                      Material(
                        type: MaterialType.transparency,
                        child: RadioListTile<EpisodeSource>(
                          title: Text(
                            '${HttpUtils.domainFromURL(x.url)} (${x.quality.code})',
                          ),
                          value: x,
                          groupValue:
                              widget.controller.currentSourceIndex != null
                                  ? widget.controller.sources![
                                      widget.controller.currentSourceIndex!]
                                  : null,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (final EpisodeSource? val) {
                            if (val != null) {
                              setState(() {
                                widget.controller.currentSourceIndex = i;
                              });
                            }

                            Logger.of('select_source')
                                .info('Popping with value');
                          },
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
              if (AppState.settings.value.anime.autoPlay)
                Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    enabled: widget.controller.currentSourceIndex != null,
                    leading: Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: shouldPersistQuality,
                      onChanged: (final bool? val) {
                        if (val is bool) {
                          setState(() {
                            shouldPersistQuality = val;
                          });
                        }
                      },
                    ),
                    title: Text(
                      Translator.t.rememberSelectedSourceQualityNextTime(),
                    ),
                    onTap: () {
                      setState(() {
                        shouldPersistQuality = !shouldPersistQuality;
                      });
                    },
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: remToPx(0.7),
                  ),
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
                      Logger.of('select_source').info('Popping with no value');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Quality? get currentQuality => widget.controller.currentSourceIndex != null
      ? widget.controller.sources
          ?.elementAt(widget.controller.currentSourceIndex!)
          .quality
      : null;

  bool get shouldPersistQuality =>
      widget.controller.animeController.lastPersistedQuality != null;

  set shouldPersistQuality(final bool val) {
    widget.controller.animeController.lastPersistedQuality =
        val ? currentQuality : null;
  }
}
