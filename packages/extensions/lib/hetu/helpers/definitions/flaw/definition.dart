import './binding.dart';
import '../../model.dart';

final HetuHelperClass hFlawClass = HetuHelperClass(
  definition: FlawClassBinding(),
  declaration: '''
external class Flaw {
  construct(err, [stack, task]);

  const err;
  const stack;
  const taskTrace;
  fun toString();

  static fun throwFlaw(err, [trace]);
}
      '''
      .trim(),
);
