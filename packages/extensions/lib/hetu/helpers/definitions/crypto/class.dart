import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as crypto;
import '../converter/bytes/class.dart';

class Crypto {
  static const crypto.AESMode defaultAesMode = crypto.AESMode.sic;

  static BytesContainer md5Convert(final BytesContainer data) =>
      BytesContainer.fromList(md5.convert(data.list).bytes);

  static BytesContainer aesDecrypt({
    required final BytesContainer encrypted,
    required final BytesContainer key,
    final BytesContainer? iv,
    final crypto.AESMode aesMode = defaultAesMode,
  }) =>
      BytesContainer.fromList(
        crypto.Encrypter(
          crypto.AES(
            crypto.Key(key.bytes),
            mode: aesMode,
          ),
        ).decryptBytes(
          crypto.Encrypted(encrypted.bytes),
          iv: iv != null ? crypto.IV(iv.bytes) : null,
        ),
      );

  // static String decryptAES(
  //   final String salted,
  //   final String decrypter,
  //   final int length,
  // ) {
  //   final Uint8List encrypted = base64.decode(salted);

  //   final Uint8List salt = encrypted.sublist(8, 16);
  //   final Uint8List data = Uint8List.fromList(decrypter.codeUnits + salt);
  //   List<int> keyIv = md5.convert(data).bytes;
  //   final BytesBuilder builtKeyIv = BytesBuilder()..add(keyIv);

  //   while (builtKeyIv.length < length) {
  //     keyIv = md5.convert(keyIv + data).bytes;
  //     builtKeyIv.add(keyIv);
  //   }

  //   final Uint8List requiredKeyIv = builtKeyIv.toBytes().sublist(0, length);
  //   final crypto.Encrypter algorithm = crypto.Encrypter(
  //     crypto.AES(
  //       crypto.Key(requiredKeyIv.sublist(0, 32)),
  //       mode: crypto.AESMode.cbc,
  //     ),
  //   );

  //   return algorithm.decrypt(
  //     crypto.Encrypted(encrypted.sublist(16)),
  //     iv: crypto.IV(requiredKeyIv.sublist(32)),
  //   );
  // }
}
