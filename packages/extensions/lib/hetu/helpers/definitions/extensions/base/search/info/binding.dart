import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:utilx/utilities/locale.dart';
import '../../../../../../../models/base/image_describer.dart';
import '../../../../../../../models/base/search/info.dart';
import '../../../../../model.dart';

class SearchInfoClassBinding extends HTExternalClass {
  SearchInfoClassBinding() : super('SearchInfo');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'SearchInfo':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              SearchInfo(
            title: namedArgs['title'] as String,
            url: namedArgs['url'] as String,
            locale: Locale.parse(namedArgs['locale'] as String),
            thumbnail: namedArgs['thumbnail'] as ImageDescriber?,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
