import './binding.dart';
import '../../model.dart';

final HetuHelperClass hHtmlElementClass = HetuHelperClass(
  definition: HtmlElementClassBinding(),
  declaration: '''
external class HtmlElement {
  final classes;
  final id;
  final text;
  final innerHtml;
  final outerHtml;
  final attributes;
  
  fun querySelector(selector);
  fun querySelectorAll(selector);

  static fun parse(html);
}
      '''
      .trim(),
);
