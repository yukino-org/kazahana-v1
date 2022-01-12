import './binding.dart';
import '../../model.dart';

final HetuHelperClass hHttpClass = HetuHelperClass(
  definition: HttpClassBinding(),
  declaration: '''
external class Http {
  static final defaultUserAgent;
  
  static fun fetch({ method, url, headers, body });
  static fun ensureURL(url);
}
      '''
      .trim(),
);
