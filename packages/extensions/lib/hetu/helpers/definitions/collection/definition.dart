import './binding.dart';
import '../../model.dart';

final HetuHelperClass hCollectionClass = HetuHelperClass(
  definition: CollectionClassBinding(),
  declaration: '''
external class Collection {
  /// (int, int) => int[]
  static fun rangeList(a, b);

  /// (T[], T[])<T = any> => T[]
  static fun mergeList(list1, list2);

  /// (T[], (int, T) => void)<T = any> => void 
  static fun eachList(list, fn);

  /// (T[], (int, T) => U)<T = any, U = any> => U[]
  static fun mapList(list, fn);

  /// (T[], (int, T) => bool)<T = any> => T[]
  static fun filterList(list, fn);

  /// (T[], (int, T) => bool)<T = any> => T?
  static fun findList(list, fn);

  /// (T[], int)<T = any, U = any> => U[]
  static fun flattenList(list, level);

  /// (T[])<T = any, U = any> => U[]
  static fun deepFlattenList(list);

  /// (Map<K, V>, Map<K, V>)<K = any, V = any> => Map<K, V>
  static fun mergeMap(map1, map2);

  /// (Map<K, V>, void Function(K, V))<K = any, V = any> => void
  static fun eachMap(map, fn);

  /// (Map<K, V>)<K = any, V = any> => [K, V][]
  static fun mapToList(map);

  /// ((int) => bool) => int
  static fun repeatUntil(repeater);
}
      '''
      .trim(),
);
