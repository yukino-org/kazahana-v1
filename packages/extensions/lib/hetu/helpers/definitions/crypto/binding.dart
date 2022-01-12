import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import './class.dart';
import '../../model.dart';

class CryptoClassBinding extends HTExternalClass {
  CryptoClassBinding() : super('Crypto');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'Crypto.decryptAES':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Crypto.decryptAES(
            positionalArgs[0] as String,
            positionalArgs[1] as String,
            positionalArgs[2] as int,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
