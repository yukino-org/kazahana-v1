import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
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
            headers: parseHetuReturnedMap(namedArgs['headers'])
                .cast<String, String>(),
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final ImageDescriber element = object as ImageDescriber;

    switch (varName) {
      case 'url':
        return element.url;

      case 'headers':
        return element.headers;

      case 'toJson':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.toJson(),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
