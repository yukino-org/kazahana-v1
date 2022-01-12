import './binding.dart';
import '../../../model.dart';

final HetuHelperClass hHttpResponseClass = HetuHelperClass(
  definition: HttpResponseClassBinding(),
  declaration: '''
external class HttpResponse {
  final body;
  final headers;
  final statusCode;
}
      '''
      .trim(),
);
