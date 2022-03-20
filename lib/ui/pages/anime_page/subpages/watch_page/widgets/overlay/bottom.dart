import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:utilx/utils.dart';
import '../../../../../../../config/defaults.dart';
import '../../../../../../../modules/app/state.dart';
import '../../../../../../../modules/database/database.dart';
import '../../../../../../../modules/helpers/ui.dart';
import '../../../../../../../modules/translator/translator.dart';
import '../../../../../../../modules/video_player/video_player.dart';
import '../../controller.dart';
import '../actions_button.dart';

class OverlayBottom extends StatefulWidget {
  const OverlayBottom({
    required final this.controller,
    final Key? key,
  }) : super(key: key);

  final WatchPageController controller;

  @override
  _OverlayBottomState createState() => _OverlayBottomState();
}

class _OverlayBottomState extends State<OverlayBottom> {
  bool wasPausedBySlider = false;
  bool showVolumeSlider = false;

  Widget buildLayoutedButton(
    final BuildContext context,
    final List<Widget> children,
    final int maxPerWhenSm,
  ) {
    final double width = MediaQuery.of(context).size.width;
    final Widget spacer = SizedBox(
      width: remToPx(0.4),
    );

    if (width < ResponsiveSizes.sm) {
      final List<List<Widget>> rows = ListUtils.chunk(children, maxPerWhenSm);

      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: rows
            .map(
              (final List<Widget> x) => Flexible(
                child: Row(
                  children: ListUtils.insertBetween(x, spacer),
                ),
              ),
            )
            .toList(),
      );
    }

    return Row(
      children: ListUtils.insertBetween(children, spacer),
    );
  }

  @override
  Widget build(final BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: buildLayoutedButton(
              context,
              <Widget>[
                Expanded(
                  child: ActionButton(
                    icon: Icons.skip_previous,
                    label: Translator.t.previous(),
                    onPressed: () {
                      widget.controller.ignoreScreenChanges = true;
                      widget.controller.previousEpisode();
                    },
                    enabled: widget.controller.previousEpisodeAvailable,
                  ),
                ),
                Expanded(
                  child: ActionButton(
                    icon: Icons.fast_forward,
                    label: Translator.t.skipIntro(),
                    onPressed: () async {
                      await widget.controller.seek(SeekType.intro);
                    },
                    enabled: widget.controller.isReady,
                  ),
                ),
                Expanded(
                  child: ActionButton(
                    icon: Icons.playlist_play,
                    label: Translator.t.sources(),
                    onPressed: () async {
                      await widget.controller.showSelectSources(context);
                    },
                    enabled: widget.controller.sources?.isNotEmpty ?? false,
                  ),
                ),
                Expanded(
                  child: ActionButton(
                    icon: Icons.skip_next,
                    label: Translator.t.next(),
                    onPressed: () {
                      widget.controller.ignoreScreenChanges = true;
                      widget.controller.nextEpisode();
                    },
                    enabled: widget.controller.nextEpisodeAvailable,
                  ),
                ),
              ],
              2,
            ),
          ),
          SizedBox(height: remToPx(0.5)),
          MouseRegion(
            onExit: (final PointerExitEvent event) async {
              if (showVolumeSlider) {
                setState(() {
                  showVolumeSlider = false;
                });
              }
            },
            child: ValueListenableBuilder<VideoDuration>(
              valueListenable: widget.controller.duration,
              builder: (
                final BuildContext context,
                final VideoDuration duration,
                final Widget? child,
              ) =>
                  Row(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      minWidth: remToPx(1.8),
                    ),
                    child: Text(
                      DurationUtils.pretty(duration.current),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackHeight: remToPx(0.15),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: remToPx(0.8),
                        ),
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: remToPx(0.3),
                        ),
                        showValueIndicator: ShowValueIndicator.always,
                        thumbColor: !widget.controller.isReady
                            ? Colors.white.withOpacity(0.5)
                            : null,
                      ),
                      child: Slider(
                        label: DurationUtils.pretty(duration.current),
                        value: duration.current.inSeconds.toDouble(),
                        max: duration.total.inSeconds.toDouble(),
                        onChanged: widget.controller.isReady
                            ? (
                                final double value,
                              ) {
                                widget.controller.duration.value =
                                    VideoDuration(
                                  Duration(seconds: value.toInt()),
                                  duration.total,
                                );
                              }
                            : null,
                        onChangeStart: widget.controller.isReady
                            ? (
                                final double value,
                              ) async {
                                if (widget.controller.isPlaying) {
                                  await widget.controller.videoPlayer!.pause();

                                  wasPausedBySlider = true;
                                }
                              }
                            : null,
                        onChangeEnd: widget.controller.isReady
                            ? (
                                final double value,
                              ) async {
                                await widget.controller.videoPlayer!.seek(
                                  Duration(seconds: value.toInt()),
                                );

                                if (wasPausedBySlider) {
                                  await widget.controller.videoPlayer!.play();
                                  wasPausedBySlider = false;
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: remToPx(1.8),
                    ),
                    child: Text(
                      DurationUtils.pretty(duration.total),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: remToPx(0.5)),
                  if (AppState.isDesktop) ...<Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(remToPx(0.2)),
                      onTap: () {},
                      onHover: (final bool _) async {
                        setState(() {
                          showVolumeSlider = true;
                        });
                      },
                      child: Icon(
                        widget.controller.volume == 0
                            ? Icons.volume_mute
                            : Icons.volume_up,
                        size: Theme.of(context).textTheme.headline6?.fontSize,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Defaults.animationsFast,
                      opacity: showVolumeSlider ? 1 : 0,
                      curve: Curves.easeInOut,
                      child: AnimatedContainer(
                        duration: Defaults.animationsNormal,
                        curve: Curves.easeInOut,
                        width: showVolumeSlider ? remToPx(8) : 0,
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: remToPx(0.15),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: remToPx(0.8),
                            ),
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: remToPx(0.3),
                            ),
                            showValueIndicator: ShowValueIndicator.always,
                            thumbColor: !widget.controller.isReady
                                ? Colors.white.withOpacity(0.5)
                                : null,
                          ),
                          child: Slider(
                            label: '${widget.controller.volume}%',
                            value: widget.controller.volume.toDouble(),
                            max: VideoPlayer.maxVolume.toDouble(),
                            onChanged: widget.controller.isReady
                                ? (
                                    final double value,
                                  ) {
                                    setState(() {
                                      widget.controller.volume = value.toInt();
                                    });
                                  }
                                : null,
                            onChangeStart: widget.controller.isReady
                                ? (
                                    final double value,
                                  ) async {
                                    setState(() {
                                      widget.controller.volume = value.toInt();
                                    });
                                  }
                                : null,
                            onChangeEnd: widget.controller.isReady
                                ? (
                                    final double value,
                                  ) async {
                                    setState(() {
                                      widget.controller.volume = value.toInt();
                                    });

                                    SettingsBox.save(
                                      AppState.settings.value
                                        ..anime.volume =
                                            widget.controller.volume,
                                    );

                                    await widget.controller.videoPlayer!
                                        .setVolume(
                                      AppState.settings.value.anime.volume,
                                    );
                                  }
                                : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: remToPx(0.7)),
                  ],
                  if (AppState.isMobile) ...<Widget>[
                    Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(remToPx(0.2)),
                        onTap: () async {
                          await widget.controller.setLandscape(
                            enabled: AppState.settings.value.anime.landscape,
                          );
                        },
                        child: Icon(
                          Icons.screen_rotation,
                          size: Theme.of(context).textTheme.headline6?.fontSize,
                        ),
                      ),
                    ),
                    SizedBox(width: remToPx(0.7)),
                  ],
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(remToPx(0.2)),
                      onTap: () async {
                        await widget.controller.setFullscreen(
                          enabled: !AppState.settings.value.anime.fullscreen,
                        );
                      },
                      child: Icon(
                        AppState.settings.value.anime.fullscreen
                            ? Icons.fullscreen_exit
                            : Icons.fullscreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: remToPx(0.5)),
        ],
      );
}
