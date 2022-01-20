import './binding.dart';
import '../../model.dart';

final HetuHelperClass hCryptoClass = HetuHelperClass(
  definition: CryptoClassBinding(),
  declaration: '''
external class Crypto {
  /// (int[]) => int[]
  static fun md5Convert(data);

  /// ({
  ///   encrypted: int[],
  ///   key: int[],
  ///   iv: int[]?,
  ///   aesMode: 'cbc' | 'cfb64' | 'ctr' | 'ecb' | 'ofb64Gctr' | 'ofb64' | 'sic' = 'sic',
  /// }) => int[];
  static fun aesDecrypt({ encrypted, key, iv, aesMode });
}
      '''
      .trim(),
);
