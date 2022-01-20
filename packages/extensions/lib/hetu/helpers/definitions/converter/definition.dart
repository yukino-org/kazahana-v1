import './binding.dart';
import '../../model.dart';

final HetuHelperClass hConverterClass = HetuHelperClass(
  definition: ConverterClassBinding(),
  declaration: '''
external class Converter {
  /// (string) => any
  static fun decodeJson(data);
  
  /// (any) => string
  static fun encodeJson(data);
  
  /// (string) => Map<string, string>
  static fun decodeQueryString(data);
  
  /// (Map<string, string>) => string
  static fun encodeQueryString(data);
}
      '''
      .trim(),
);
