import 'dart:convert';

class Converter {
  static String encodeJson(final dynamic data) => json.encode(data);

  static dynamic decodeJson(final String data) => json.decode(data);

  static String encodeQueryString(final Map<dynamic, dynamic> map) =>
      Uri(queryParameters: map.cast<String, String>()).query;

  static Map<String, String> decodeQueryString(final String query) =>
      Uri.splitQueryString(query);
}
