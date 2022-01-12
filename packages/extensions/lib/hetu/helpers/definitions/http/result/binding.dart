import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';

class HttpResponseClassBinding extends HTExternalClass {
  HttpResponseClassBinding() : super('HttpResponse');

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final HttpResponse element = object as HttpResponse;

    switch (varName) {
      case 'body':
        return element.body;

      case 'headers':
        return element.headers;

      case 'statusCode':
        return element.statusCode;

      default:
        throw HTError.undefined(varName);
    }
  }
}
