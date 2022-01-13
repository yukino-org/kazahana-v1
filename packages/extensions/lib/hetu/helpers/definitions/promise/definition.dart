import './binding.dart';
import '../../model.dart';

final HetuHelperClass hPromiseClass = HetuHelperClass(
  definition: PromiseClassBinding(),
  declaration: '''
external class Promise {
  static fun resolve(function, { trace, onDone, onFail });
  static fun resolveAll(functions, { trace, onDone, onFail });
  static fun wait(ms, callback);
}
      '''
      .trim(),
);
