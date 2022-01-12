class HttpResponse {
  const HttpResponse({
    required final this.body,
    required final this.headers,
    required final this.statusCode,
  });

  final String body;
  final Map<String, String> headers;
  final int statusCode;
}
