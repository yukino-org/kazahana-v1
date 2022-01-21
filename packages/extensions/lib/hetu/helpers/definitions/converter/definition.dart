import './binding.dart';
import '../../model.dart';

final HetuHelperClass hConverterClass = HetuHelperClass(
  definition: ConverterClassBinding(),
  declaration: '''
external class Converter {
  /// (any) => string
  static fun jsonEncode(data);

  /// (string) => any
  static fun jsonDecode(data);
  
  /// (Map<string, string>) => string
  static fun queryStringEncode(data);
  
  /// (string) => Map<string, string>
  static fun queryStringDecode(data);

  /// (BytesContainer) => string
  static fun base64Encode(data);

  /// (string) => BytesContainer
  static fun base64Decode(data);

  /// (string) => BytesContainer
  static fun utf8Encode(data);

  /// (BytesContainer) => string
  static fun utf8Decode(data);
}
      '''
      .trim(),
);
