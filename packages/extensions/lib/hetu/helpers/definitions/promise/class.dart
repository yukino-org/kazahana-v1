import 'dart:async';
import 'package:hetu_script/values.dart';
import '../flaw/class.dart';

class Promise {
  static Future<dynamic> resolve(
    final HTFunction function,
    final HTFunction successCallback, [
    final HTFunction? failureCallback,
  ]) async {
    try {
      final dynamic result = await function();

      return await successCallback.call(positionalArgs: <dynamic>[result]);
    } catch (err, stack) {
      final Error flaw = Flaw.fromError(err, stack);

      if (failureCallback != null) {
        return await failureCallback.call(positionalArgs: <dynamic>[flaw]);
      } else {
        await Future<void>.error(flaw, stack);
      }
    }
  }

  static Future<dynamic> resolveAll(
    final List<HTFunction> functions,
    final HTFunction successCallback, [
    final HTFunction? failureCallback,
  ]) async {
    try {
      final dynamic result = await Future.wait(
        functions.map((final HTFunction x) => x.call() as Future<dynamic>),
      ).timeout(const Duration(seconds: 30));

      return await successCallback.call(positionalArgs: <dynamic>[result]);
    } catch (err, stack) {
      final Error flaw = Flaw.fromError(err, stack);

      if (failureCallback != null) {
        return await failureCallback.call(positionalArgs: <dynamic>[flaw]);
      } else {
        await Future<void>.error(flaw, stack);
      }
    }
  }

  static Future<dynamic> wait(
    final int ms,
    final HTFunction callback,
  ) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
    return await callback.call();
  }
}
