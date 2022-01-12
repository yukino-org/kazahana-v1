import './binding.dart';
import '../../model.dart';

final HetuHelperClass hCryptoClass = HetuHelperClass(
  definition: CryptoClassBinding(),
  declaration: '''
external class Crypto {
  static fun decryptAES(salted, decrypter, length);
}
      '''
      .trim(),
);
