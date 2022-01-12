import './binding.dart';
import '../../model.dart';

final HetuHelperClass hTaskTraceClass = HetuHelperClass(
  definition: TaskTraceClassBinding(),
  declaration: '''
external class TaskTrace {
  construct();

  fun add(line: str);
  fun toString();
}
      '''
      .trim(),
);
