import 'package:hetu_script/value/function/function.dart';

class FuzzySearchKey {
  const FuzzySearchKey({
    required final this.getter,
    required final this.weight,
  });

  final double weight;
  final HTFunction getter;

  static const double defaultWeight = 1;
}
