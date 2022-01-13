enum Qualities {
  q_144p,
  q_360p,
  q_480p,
  q_720p,
  q_1080p,
  unknown,
}

class Quality {
  const Quality(this.quality, this.code, this.short);

  final Qualities quality;
  final String code;
  final String short;

  static final Map<Qualities, Quality> qualities = const <Quality>[
    Quality(Qualities.q_144p, '144p', 'sd'),
    Quality(Qualities.q_360p, '360p', 'sd'),
    Quality(Qualities.q_480p, '480p', 'sd'),
    Quality(Qualities.q_720p, '720p', 'hd'),
    Quality(Qualities.q_1080p, '1080p', 'fhd'),
    Quality(Qualities.unknown, 'unknown', '?'),
  ].asMap().map(
        (final int k, final Quality x) =>
            MapEntry<Qualities, Quality>(x.quality, x),
      );

  static Quality get(final Qualities q) => qualities[q]!;

  static Quality parse(final String _approx) {
    final String approx = _approx.toLowerCase();
    for (final Quality q in qualities.values) {
      if (q.code == approx ||
          q.code.substring(0, q.code.length - 1) == approx ||
          q.short == approx) return q;
    }
    return get(Qualities.unknown);
  }
}
