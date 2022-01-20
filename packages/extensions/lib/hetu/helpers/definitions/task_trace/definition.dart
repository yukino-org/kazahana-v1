import './binding.dart';
import '../../model.dart';

final HetuHelperClass hTaskTraceClass = HetuHelperClass(
  definition: TaskTraceClassBinding(),
  declaration: '''
external class TaskTrace {
  construct();

  /// (string) => void
  fun add(line);

  /// () => string
  fun toString();
}
      '''
      .trim(),
);
