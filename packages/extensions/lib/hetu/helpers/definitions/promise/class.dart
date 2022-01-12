import 'dart:async';
import 'package:hetu_script/values.dart';
import '../flaw/class.dart';

class Promise {
  static Future<dynamic> resolve(
    final HTFunction function,
    final HTFunction callback,
  ) async {
    dynamic result;
    Error? error;

    try {
      result = await function();
    } catch (err, stack) {
      error = Flaw.fromError(err, stack);
    }

    return await callback.call(positionalArgs: <dynamic>[error, result]);
  }

  static Future<dynamic> resolveAll(
    final List<HTFunction> functions,
    final HTFunction callback,
  ) async {
    List<dynamic>? result;
    Flaw? error;

    try {
      result = await Future.wait(
        functions.map((final HTFunction x) => x.call() as Future<dynamic>),
      ).timeout(const Duration(seconds: 30));
    } catch (err, stack) {
      error = Flaw.fromError(err, stack);
    }

    return await callback.call(positionalArgs: <dynamic>[error, result]);
  }

  static Future<dynamic> wait(
    final int ms,
    final HTFunction callback,
  ) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
    return await callback.call();
  }
}
