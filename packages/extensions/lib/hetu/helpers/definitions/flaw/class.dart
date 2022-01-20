import '../task_trace/class.dart';

class Flaw implements Error {
  const Flaw(this.err, [this.stack, this.trace]);

  factory Flaw.fromError(
    final Object error, [
    final StackTrace? stack,
    final TaskTrace? trace,
  ]) =>
      Flaw(error.toString(), stack?.toString(), trace);

  final String err;
  final String? stack;
  final TaskTrace? trace;

  Flaw copyWith(
    final Flaw err, [
    final String? stack,
    final TaskTrace? task,
  ]) =>
      Flaw(err.err, stack ?? err.stack, task ?? err.trace);

  String prettyString() => '$err\n$stackTrace';

  @override
  StackTrace get stackTrace {
    final String stackString = _indentString(stack?.toString() ?? '-', '  ');
    final String taskString = _indentString(trace?.toString() ?? '-', '  ');

    return StackTrace.fromString(
      'Stack Trace:\n$stackString\nTask Trace:\n$taskString',
    );
  }

  @override
  String toString() => err;

  static String _indentString(final String str, final String prefix) =>
      str.split('\n').map((final String x) => '$prefix$x').join('\n');

  static void throwFlaw(final dynamic err, [final TaskTrace? trace]) {
    if (err is Flaw) {
      throw err.copyWith(err, null, trace);
    }

    final String task = _indentString(trace?.toString() ?? '-', '  ');
    throw '$err\nTaskTrace:\n$task';
  }
}
