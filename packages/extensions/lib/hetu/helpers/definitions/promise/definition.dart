import './binding.dart';
import '../../model.dart';

final HetuHelperClass hPromiseClass = HetuHelperClass(
  definition: PromiseClassBinding(),
  declaration: '''
external class Promise {
  /// (() => DartFutureOr<T>, {
  ///   trace: TaskTrace,
  ///   onDone: (T) => DartFutureOr<U>,
  ///   onFail: (Flaw) => DartFutureOr<U>,
  /// })<T = any, U = any> => DartFuture<U>;
  static fun resolve(function, { trace, onDone, onFail });
  
  /// ((() => DartFutureOr<T>)[], {
  ///   trace: TaskTrace,
  ///   onDone: (T[]) => DartFutureOr<U>,
  ///   onFail: (Flaw) => DartFutureOr<U>,
  /// })<T = any, U = any> => DartFuture<U>;
  static fun resolveAll(functions, { trace, onDone, onFail });
  
  /// (int, () => DartFutureOr<T>)<T = any> => DartFuture<T>;
  static fun wait(ms, callback);
}
      '''
      .trim(),
);
