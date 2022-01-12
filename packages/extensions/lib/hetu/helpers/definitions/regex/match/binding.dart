import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';

class RegexMatchClassBinding extends HTExternalClass {
  RegexMatchClassBinding() : super('RegexMatch');

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final RegExpMatch element = object as RegExpMatch;
    switch (varName) {
      case 'input':
        return element.input;

      case 'group':
        return ({
          final List<dynamic> positionalArgs = const <dynamic>[],
          final Map<String, dynamic> namedArgs = const <String, dynamic>{},
          final List<HTType> typeArgs = const <HTType>[],
        }) =>
            element.group(positionalArgs.first as int);

      default:
        throw HTError.undefined(varName);
    }
  }
}
