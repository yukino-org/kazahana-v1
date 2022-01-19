import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import '../../../../../../models/base/image_describer.dart';
import '../../../../model.dart';

class ImageDescriberClassBinding extends HTExternalClass {
  ImageDescriberClassBinding() : super('ImageDescriber');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'ImageDescriber':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              ImageDescriber(
            url: namedArgs['url'] as String,
            headers: (namedArgs['headers'] as HTStruct)
                .toJson()
                .cast<String, String>(),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
