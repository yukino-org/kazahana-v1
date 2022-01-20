import 'dart:async';
import 'package:hetu_script/values.dart';
import '../flaw/class.dart';
import '../task_trace/class.dart';

class Promise {
  static Future<dynamic> resolve(
    final HTFunction function, {
    required final HTFunction onDone,
    final HTFunction? onFail,
    final TaskTrace? trace,
  }) async {
    try {
      final dynamic result = await function();

      return await onDone.call(positionalArgs: <dynamic>[result]);
    } catch (err, stack) {
      final Error flaw = Flaw.fromError(err, stack, trace);

      if (onFail != null) {
        return await onFail.call(positionalArgs: <dynamic>[flaw]);
      } else {
        await Future<void>.error(flaw, stack);
      }
    }
  }

  static Future<dynamic> resolveAll(
    final List<HTFunction> functions, {
    required final HTFunction onDone,
    final HTFunction? onFail,
    final TaskTrace? trace,
  }) async {
    try {
      final List<dynamic> result = await Future.wait(
        functions.map((final HTFunction x) => x.call() as Future<dynamic>),
      ).timeout(const Duration(seconds: 30));

      return await onDone.call(positionalArgs: <dynamic>[result]);
    } catch (err, stack) {
      final Error flaw = Flaw.fromError(err, stack, trace);

      if (onFail != null) {
        return await onFail.call(positionalArgs: <dynamic>[flaw]);
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
