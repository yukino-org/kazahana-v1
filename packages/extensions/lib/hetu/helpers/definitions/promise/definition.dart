import './binding.dart';
import '../../model.dart';

final HetuHelperClass hPromiseClass = HetuHelperClass(
  definition: PromiseClassBinding(),
  declaration: '''
external class Promise {
  static fun resolve(function, successCallback, [failureCallback]);
  static fun resolveAll(functions, successCallback, [failureCallback]);
  static fun wait(ms, callback);
}
      '''
      .trim(),
);
