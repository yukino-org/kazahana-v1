String strFmt(
  final String template,
  final Map<String, String> values, {
  final String startDelimiter = '{',
  final String endDelimiter = '}',
}) =>
    values.entries.fold(
      '',
      (final String value, final MapEntry<String, String> x) =>
          value.replaceAll('$startDelimiter${x.key}$endDelimiter', x.value),
    );
