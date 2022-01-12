import './match/class.dart';

class Regex {
  const Regex(this._stringified);

  final String _stringified;

  RegexMatch? firstMatch(final String text) {
    final RegExpMatch? match = _regex.firstMatch(text);
    return match != null ? RegexMatch.fromRegExpMatch(match) : null;
  }

  List<RegexMatch> allMatches(final String text) => _regex
      .allMatches(text)
      .map((final RegExpMatch x) => RegexMatch.fromRegExpMatch(x))
      .toList();

  String replaceFirst(final String data, final String to) =>
      data.replaceFirst(_regex, to);

  String replaceAll(final String data, final String to) =>
      data.replaceAll(_regex, to);

  RegExp get _regex => RegExp(_stringified);
}
