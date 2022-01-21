import './binding.dart';
import '../../model.dart';

final HetuHelperClass hClockClass = HetuHelperClass(
  definition: ClockClassBinding(),
  declaration: '''
external class Clock {
  /// int
  get date;

  /// int
  get month;

  /// int
  get year;

  /// int
  get inMs;

  /// (int) => Clock
  static fun fromMs(data);

  /// () => Clock
  static fun now();
}
      '''
      .trim(),
);
