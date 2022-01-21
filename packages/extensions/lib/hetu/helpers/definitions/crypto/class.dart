import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as crypto;
import '../converter/bytes/class.dart';

class Crypto {
  static const crypto.AESMode defaultAesMode = crypto.AESMode.sic;

  static BytesContainer md5Convert(final BytesContainer data) =>
      BytesContainer.fromList(md5.convert(data.list).bytes);

  static BytesContainer aesEncrypt({
    required final BytesContainer input,
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
        )
            .encryptBytes(
              input.bytes,
              iv: iv != null ? crypto.IV(iv.bytes) : null,
            )
            .bytes,
      );

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
}
