import 'package:hetu_script/values.dart';

class Collection {
  static List<int> rangeList(final int a, final int b) {
    final int length = (b - a).abs();
    return b > a
        ? List<int>.generate(length, (final int i) => i + a)
        : List<int>.generate(length, (final int i) => a - i);
  }

  static List<dynamic> mergeList(
    final List<dynamic> m1,
    final List<dynamic> m2,
  ) =>
      <dynamic>[
        ...m1,
        ...m2,
      ];

  static void eachList(
    final List<dynamic> data,
    final HTFunction fn,
  ) {
    data.asMap().forEach(
      (final int i, final dynamic x) {
        fn.call(positionalArgs: <dynamic>[i, x]);
      },
    );
  }

  static List<dynamic> mapList(
    final List<dynamic> data,
    final HTFunction fn,
  ) =>
      data
          .asMap()
          .map(
            (final int i, final dynamic x) => MapEntry<int, dynamic>(
              i,
              fn.call(positionalArgs: <dynamic>[i, x]),
            ),
          )
          .values
          .toList();

  static List<dynamic> filterList(
    final List<dynamic> data,
    final HTFunction fn,
  ) {
    final List<dynamic> out = <dynamic>[];

    for (int i = 0; i < data.length; i++) {
      if (fn.call(positionalArgs: <dynamic>[i, data[i]]) as bool) {
        out.add(data[i]);
      }
    }

    return out;
  }

  static dynamic findList(
    final List<dynamic> data,
    final HTFunction fn,
  ) {
    for (int i = 0; i < data.length; i++) {
      if (fn.call(positionalArgs: <dynamic>[i, data[i]]) as bool) {
        return data[i];
      }
    }

    return null;
  }

  static List<dynamic> flattenList(final List<dynamic> data, final int level) =>
      data.cast<List<dynamic>>().expand((final List<dynamic> x) {
        Iterable<dynamic> flat = x;
        int done = 1;

        while (done < level) {
          flat =
              flat.cast<List<dynamic>>().expand((final List<dynamic> x) => x);
          done++;
        }

        return flat;
      }).toList();

  static List<dynamic> deepFlattenList(final List<dynamic> data) {
    final List<dynamic> flat = <dynamic>[];

    for (final dynamic x in data) {
      if (x is List) {
        flat.addAll(deepFlattenList(x));
      } else {
        flat.add(x);
      }
    }

    return flat;
  }

  static Map<dynamic, dynamic> mergeMap(
    final Map<dynamic, dynamic> m1,
    final Map<dynamic, dynamic> m2,
  ) =>
      <dynamic, dynamic>{
        ...m1,
        ...m2,
      };

  static void eachMap(
    final Map<dynamic, dynamic> data,
    final HTFunction fn,
  ) {
    for (final MapEntry<dynamic, dynamic> x in data.entries) {
      if (fn.call(positionalArgs: <dynamic>[x.key, x.value]) == false) {
        break;
      }
    }
  }

  static List<Map<dynamic, dynamic>> mapToList(
    final Map<dynamic, dynamic> data,
  ) =>
      data.entries
          .map(
            (final MapEntry<dynamic, dynamic> x) => <dynamic, dynamic>{
              'key': x.key,
              'value': x.value,
            },
          )
          .toList();

  static int repeatUntil(final HTFunction repeater) {
    int i = 0;
    while (repeater.call(positionalArgs: <dynamic>[i++]) as bool) {}

    return i;
  }
}
