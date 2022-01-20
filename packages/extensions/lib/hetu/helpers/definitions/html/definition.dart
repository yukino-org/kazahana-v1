import './binding.dart';
import '../../model.dart';

final HetuHelperClass hHtmlElementClass = HetuHelperClass(
  definition: HtmlElementClassBinding(),
  declaration: '''
external class HtmlElement {
  /// string[]
  get classes;

  /// string
  get id;

  /// string
  get text;

  /// string
  get innerHtml;

  /// string
  get outerHtml;

  /// Map<string, string>
  get attributes;
  
  /// (string) => HtmlElement
  fun querySelector(selector);
  
  /// (string) => HtmlElement[]
  fun querySelectorAll(selector);

  /// (string) => HtmlElement
  static fun parse(html);
}
      '''
      .trim(),
);
