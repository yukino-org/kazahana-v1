import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';
import '../../model.dart';

class HtmlElementClassBinding extends HTExternalClass {
  HtmlElementClassBinding() : super('HtmlElement');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'HtmlElement.parse':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              HtmlElement.parse(positionalArgs[0] as String),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final HtmlElement element = object as HtmlElement;

    switch (varName) {
      case 'classes':
        return element.classes;

      case 'id':
        return element.id;

      case 'text':
        return element.text;

      case 'innerHtml':
        return element.innerHtml;

      case 'outerHtml':
        return element.outerHtml;

      case 'attributes':
        return element.attributes;

      case 'querySelector':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.querySelector(positionalArgs.first as String),
        );

      case 'querySelectorAll':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              element.querySelectorAll(positionalArgs.first as String),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
