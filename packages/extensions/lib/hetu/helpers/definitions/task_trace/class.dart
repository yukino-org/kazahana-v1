class TaskTrace {
  int _n = 0;
  final List<String> _traces = <String>[];

  void add(final String line) {
    _traces.add('#$_n $line');
    _n++;
  }

  @override
  String toString() => _traces.join('\n');
}
