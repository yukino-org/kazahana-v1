import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';
import '../../model.dart';

class LanguagesClassBinding extends HTExternalClass {
  LanguagesClassBinding() : super('Languages');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Languages.isValid':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Languages.isValid(positionalArgs[0] as String),
        );

      case 'Languages.all':
        return Languages.all;

      default:
        throw HTError.undefined(varName);
    }
  }
}
