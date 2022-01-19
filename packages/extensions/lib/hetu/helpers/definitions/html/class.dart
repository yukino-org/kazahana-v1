import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;

class HtmlElement {
  const HtmlElement(this._element);

  factory HtmlElement.parse(final String _html) =>
      HtmlElement.fromDocument(html.parse(_html));

  factory HtmlElement.fromDocument(final dom.Document document) =>
      HtmlElement(document.documentElement!);

  final dom.Element _element;

  List<String> get classes => _element.classes.toList();

  String get id => _element.id;
  String get text => _element.text;
  String get innerHtml => _element.innerHtml;
  String get outerHtml => _element.outerHtml;

  Map<String, String> get attributes => <String, String>{}..addEntries(
      _element.attributes.entries
          .where((final MapEntry<Object, String> x) => x.key is String)
          .map(
            (final MapEntry<Object, String> x) =>
                MapEntry<String, String>(x.key as String, x.value),
          ),
    );

  HtmlElement? querySelector(final String selector) {
    final dom.Element? found = _element.querySelector(selector);
    return found != null ? HtmlElement(found) : null;
  }

  List<HtmlElement> querySelectorAll(final String selector) => _element
      .querySelectorAll(selector)
      .map((final dom.Element e) => HtmlElement(e))
      .toList();
}
