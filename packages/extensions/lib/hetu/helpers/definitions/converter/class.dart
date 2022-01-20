import 'dart:convert';
import './bytes/class.dart';

class Converter {
  static String jsonEncode(final dynamic data) => json.encode(data);

  static dynamic jsonDecode(final String data) => json.decode(data);

  static String queryStringEncode(final Map<dynamic, dynamic> map) =>
      Uri(queryParameters: map.cast<String, String>()).query;

  static Map<String, String> queryStringDecode(final String query) =>
      Uri.splitQueryString(query);

  static String base64Encode(final BytesContainer data) =>
      base64.encode(data.list);

  static BytesContainer base64Decode(final String data) =>
      BytesContainer.fromList(base64.decode(data));

  static BytesContainer utf8Encode(final String data) =>
      BytesContainer.fromList(utf8.encode(data));

  static String utf8Decode(final BytesContainer data) => utf8.decode(data.list);
}
