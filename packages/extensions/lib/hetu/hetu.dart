import 'package:hetu_script/hetu_script.dart';
import './helpers/exports.dart';

class ModifiedHetuError {
  const ModifiedHetuError({
    required final this.error,
    final this.line,
  });

  final HTError error;
  final int? line;

  @override
  String toString() => error.toString().replaceFirst(
        'Line: ${error.line}',
        'Thrown Line: ${error.line}, Purged Line: ${line ?? '-'}',
      );
}

abstract class HetuManager {
  static int? _hetuDepLines;

  static Future<Hetu> create() async {
    final Hetu hetu = Hetu();

    hetu.init(
      externalClasses: HetuHelperExports.externalClasses,
      externalFunctions: HetuHelperExports.externalFunctions,
    );

    return hetu;
  }

  static String prependDefinitions(final String code) => '''
${HetuHelperExports.declarations}

$code
''';

  static ModifiedHetuError getModifiedError(final HTError error) {
    _hetuDepLines ??=
        RegExp('\n').allMatches(prependDefinitions('')).length - 1;

    return ModifiedHetuError(error: error, line: error.line! - _hetuDepLines!);
  }
}
