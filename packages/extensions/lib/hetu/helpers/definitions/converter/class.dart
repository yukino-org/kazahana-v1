import 'dart:convert';

class Converter {
  static dynamic decodeJson(final String data) => json.decode(data);

  static String encodeJson(final dynamic data) => json.encode(data);

  static Map<String, String> decodeQueryString(final String query) =>
      Uri.splitQueryString(query);

  static String encodeQueryString(final Map<dynamic, dynamic> map) =>
      Uri(queryParameters: map.cast<String, String>()).query;
}
