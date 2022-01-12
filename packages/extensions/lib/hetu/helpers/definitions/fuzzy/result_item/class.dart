class FuzzySearchResultItem {
  const FuzzySearchResultItem({
    required final this.item,
    required final this.score,
  });

  final Map<dynamic, dynamic> item;
  final double score;
}
