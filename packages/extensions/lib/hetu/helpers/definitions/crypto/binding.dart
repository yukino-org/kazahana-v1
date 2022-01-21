import 'package:encrypt/encrypt.dart' as crypto;
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:utilx/utilities/utils.dart';
import './class.dart';
import '../../model.dart';
import '../converter/bytes/class.dart';

class CryptoClassBinding extends HTExternalClass {
  CryptoClassBinding() : super('Crypto');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'Crypto.md5Convert':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Crypto.md5Convert(positionalArgs[0] as BytesContainer),
        );

      case 'Crypto.aesEncrypt':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Crypto.aesEncrypt(
            input: namedArgs['input'] as BytesContainer,
            key: namedArgs['key'] as BytesContainer,
            iv: namedArgs['iv'] as BytesContainer?,
            aesMode: namedArgs['aesMode'] is String
                ? EnumUtils.find(
                    crypto.AESMode.values,
                    namedArgs['aesMode'] as String,
                  )
                : Crypto.defaultAesMode,
          ),
        );

      case 'Crypto.aesDecrypt':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Crypto.aesDecrypt(
            encrypted: namedArgs['encrypted'] as BytesContainer,
            key: namedArgs['key'] as BytesContainer,
            iv: namedArgs['iv'] as BytesContainer?,
            aesMode: namedArgs['aesMode'] is String
                ? EnumUtils.find(
                    crypto.AESMode.values,
                    namedArgs['aesMode'] as String,
                  )
                : Crypto.defaultAesMode,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
