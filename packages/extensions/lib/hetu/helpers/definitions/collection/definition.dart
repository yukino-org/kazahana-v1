import './binding.dart';
import '../../model.dart';

final HetuHelperClass hCollectionClass = HetuHelperClass(
  definition: CollectionClassBinding(),
  declaration: '''
external class Collection {
  static fun rangeList(a, b);
  static fun mergeList(list1, list2);
  static fun eachList(list, fn);
  static fun mapList(list, fn);
  static fun filterList(list, fn);
  static fun findList(list, fn);
  static fun flattenList(list, level);
  static fun deepFlattenList(list);
  static fun mergeMap(map1, map2);
  static fun eachMap(map, fn);
  static fun mapToList(map);
}
      '''
      .trim(),
);
