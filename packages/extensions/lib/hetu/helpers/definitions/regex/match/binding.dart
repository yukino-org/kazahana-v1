import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';
import '../../../model.dart';

class RegexMatchClassBinding extends HTExternalClass {
  RegexMatchClassBinding() : super('RegexMatch');

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final RegexMatch element = object as RegexMatch;

    switch (varName) {
      case 'input':
        return element.input;

      case 'group':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.group(positionalArgs.first as int),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
