import './binding.dart';
import '../../../../../model.dart';

final HetuHelperClass hEpisodeInfoClass = HetuHelperClass(
  definition: EpisodeInfoClassBinding(),
  declaration: '''
external class EpisodeInfo {
  /// ({
  ///   episode: string,
  ///   url: string,
  ///   locale: string,
  /// }) => EpisodeInfo;
  construct({ episode, url, locale });

  /// string
  get episode;

  /// string
  get url;

  /// string
  get locale;

  /// () => Map<dynamic, dynamic>
  fun toJson();
}
      '''
      .trim(),
);
