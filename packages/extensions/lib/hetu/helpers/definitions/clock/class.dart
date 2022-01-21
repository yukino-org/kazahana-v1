class Clock {
  const Clock(this.time);

  factory Clock.fromISO(final String iso) => Clock(DateTime.parse(iso));

  factory Clock.fromMs(final int ms) =>
      Clock(DateTime.fromMillisecondsSinceEpoch(ms));

  factory Clock.now() => Clock(DateTime.now());

  final DateTime time;

  String toISOString() => time.toIso8601String();

  int get date => time.day;
  int get month => time.month;
  int get year => time.year;

  int get inMs => time.millisecondsSinceEpoch;
}
