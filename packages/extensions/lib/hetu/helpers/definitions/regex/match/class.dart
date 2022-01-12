class RegexMatch {
  const RegexMatch({
    required final this.input,
    required final this.group,
  });

  factory RegexMatch.fromRegExpMatch(final RegExpMatch match) => RegexMatch(
        input: match.input,
        group: match.group,
      );

  final String input;
  final String? Function(int) group;
}
