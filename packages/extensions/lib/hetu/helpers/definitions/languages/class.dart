import 'package:utilx/generated/locale.g.dart';

class Languages {
  static bool isValid(final String language) =>
      LanguageUtils.nameCodeMap.containsKey(language);

  static List<String> get all => LanguageUtils.nameCodeMap.keys.toList();
}
