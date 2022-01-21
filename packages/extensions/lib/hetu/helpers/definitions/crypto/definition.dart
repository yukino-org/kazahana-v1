import './binding.dart';
import '../../model.dart';

final HetuHelperClass hCryptoClass = HetuHelperClass(
  definition: CryptoClassBinding(),
  declaration: '''
external class Crypto {
  /// (BytesContainer) => BytesContainer
  static fun md5Convert(data);

  /// ({
  ///   input: BytesContainer,
  ///   key: BytesContainer,
  ///   iv: BytesContainer?,
  ///   aesMode: 'cbc' | 'cfb64' | 'ctr' | 'ecb' | 'ofb64Gctr' | 'ofb64' | 'sic' = 'sic',
  /// }) => BytesContainer;
  static fun aesEncrypt({ input, key, iv, aesMode });

  /// ({
  ///   encrypted: BytesContainer,
  ///   key: BytesContainer,
  ///   iv: BytesContainer?,
  ///   aesMode: 'cbc' | 'cfb64' | 'ctr' | 'ecb' | 'ofb64Gctr' | 'ofb64' | 'sic' = 'sic',
  /// }) => BytesContainer;
  static fun aesDecrypt({ encrypted, key, iv, aesMode });
}
      '''
      .trim(),
);
