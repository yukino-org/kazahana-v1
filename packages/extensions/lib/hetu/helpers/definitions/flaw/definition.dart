import './binding.dart';
import '../../model.dart';

final HetuHelperClass hFlawClass = HetuHelperClass(
  definition: FlawClassBinding(),
  declaration: '''
external class Flaw {
  /// (string, string?, TaskTrace?) => Flaw;
  construct(err, [stack, task]);
  
  /// string
  final err;
  
  /// string
  final stack;
  
  /// TaskTrace
  final trace;

  /// () => string
  fun toString();

  /// (Flaw | any, TaskTrace?) => never
  static fun throwFlaw(err, [trace]);
}
      '''
      .trim(),
);
