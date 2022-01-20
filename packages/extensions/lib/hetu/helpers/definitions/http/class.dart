import 'package:http/http.dart';
import './client.dart';
import './result/class.dart';
import '../../../../utils/http.dart';

class Http {
  static Future<HttpResponse> fetch({
    required final String method,
    required final String url,
    final Map<String, String>? headers,
    final String? body,
  }) async {
    final String encodedURL = HttpUtils.tryEncodeURL(url);
    final Map<String, String> castedHeaders =
        headers?.cast<String, String>() ?? <String, String>{};

    final Response res;
    switch (method) {
      case 'get':
        res = await HetuHttpClient.client
            .get(Uri.parse(encodedURL), headers: castedHeaders)
            .timeout(HttpUtils.timeout);
        break;

      case 'post':
        res = await HetuHttpClient.client
            .post(Uri.parse(encodedURL), body: body, headers: castedHeaders)
            .timeout(HttpUtils.timeout);
        break;

      case 'head':
        res = await HetuHttpClient.client
            .head(Uri.parse(encodedURL), headers: castedHeaders)
            .timeout(HttpUtils.timeout);
        break;

      case 'patch':
        res = await HetuHttpClient.client
            .patch(Uri.parse(encodedURL), body: body, headers: castedHeaders)
            .timeout(HttpUtils.timeout);
        break;

      case 'delete':
        res = await HetuHttpClient.client
            .delete(Uri.parse(encodedURL), body: body, headers: castedHeaders)
            .timeout(HttpUtils.timeout);
        break;

      case 'put':
        res = await HetuHttpClient.client
            .put(Uri.parse(encodedURL), body: body, headers: castedHeaders)
            .timeout(HttpUtils.timeout);
        break;

      default:
        throw AssertionError('Unknown "method": $method');
    }

    return HttpResponse(
      body: res.body,
      headers: res.headers,
      statusCode: res.statusCode,
    );
  }

  static String ensureURL(final String url) => HttpUtils.ensureURL(url);

  static String get defaultUserAgent => HttpUtils.userAgent;
}
