import '../task_trace/class.dart';

class Flaw implements Error {
  const Flaw(this.err, [this.stack, this.task]);

  factory Flaw.fromError(final Object error, [final StackTrace? trace]) =>
      Flaw(error.toString(), trace?.toString());

  final String err;
  final String? stack;
  final TaskTrace? task;

  Flaw copyWith(
    final Flaw err, [
    final String? stack,
    final TaskTrace? task,
  ]) =>
      Flaw(err.err, stack ?? err.stack, task ?? err.task);

  String prettyString() => '$err\n$stackTrace';

  @override
  StackTrace get stackTrace {
    final String stackString = _indentString(stack?.toString() ?? '-', '  ');
    final String taskString = _indentString(task?.toString() ?? '-', '  ');

    return StackTrace.fromString(
      'Stack Trace:\n$stackString\nTask Trace:\n$taskString',
    );
  }

  @override
  String toString() => err;

  static String _indentString(final String str, final String prefix) =>
      str.split('\n').map((final String x) => '$prefix$x').join('\n');

  static void throwFlaw(final dynamic err, [final TaskTrace? taskTrace]) {
    if (err is Flaw) {
      throw err.copyWith(err, null, taskTrace);
    }

    final String task = _indentString(taskTrace?.toString() ?? '-', '  ');
    throw '$err\nTaskTrace:\n$task';
  }
}
