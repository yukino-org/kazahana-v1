import './binding.dart';
import '../../model.dart';

final HetuHelperClass hCryptoClass = HetuHelperClass(
  definition: CryptoClassBinding(),
  declaration: '''
external class Crypto {
  /// TODO: Make it more basic
  static fun decryptAES(salted, decrypter, length);
}
      '''
      .trim(),
);
