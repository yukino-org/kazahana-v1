import './binding.dart';
import '../../../../../model.dart';

final HetuHelperClass hEpisodeSourceClass = HetuHelperClass(
  definition: EpisodeSourceClassBinding(),
  declaration: '''
external class EpisodeSource {
  construct({ url, quality, headers, locale });
}
      '''
      .trim(),
);
