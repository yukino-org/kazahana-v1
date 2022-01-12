import './binding.dart';
import '../../model.dart';

final HetuHelperClass hPromiseClass = HetuHelperClass(
  definition: PromiseClassBinding(),
  declaration: '''
external class Promise {
  static fun resolve(function, callback);
  static fun resolveAll(functions, callback);
  static fun wait(ms, callback);
}
      '''
      .trim(),
);
