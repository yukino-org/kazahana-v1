import './binding.dart';
import '../../model.dart';

final HetuHelperClass hHttpClass = HetuHelperClass(
  definition: HttpClassBinding(),
  declaration: '''
external class Http {
  /// ({
  ///   method: 'get' | 'post' | 'head' | 'patch' | 'delete' | 'put',
  ///   url: string,
  ///   headers: Map<string, string>,
  ///   body: string?,
  /// }) => HttpResponse;
  static fun fetch({ method, url, headers, body });
  
  /// (string) => string
  static fun ensureURL(url);
  
  /// string
  static get defaultUserAgent;
}
      '''
      .trim(),
);
