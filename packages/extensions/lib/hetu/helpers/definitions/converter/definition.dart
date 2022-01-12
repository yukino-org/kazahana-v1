import './binding.dart';
import '../../model.dart';

final HetuHelperClass hConverterClass = HetuHelperClass(
  definition: ConverterClassBinding(),
  declaration: '''
external class Converter {  
  static fun decodeJson(data);
  static fun encodeJson(data);
  static fun decodeQueryString(data);
  static fun encodeQueryString(data);
}
      '''
      .trim(),
);
