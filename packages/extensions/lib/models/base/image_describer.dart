class ImageDescriber {
  const ImageDescriber({
    required final this.url,
    final this.headers = const <String, String>{},
  });

  factory ImageDescriber.fromJson(final Map<dynamic, dynamic> json) =>
      ImageDescriber(
        url: json['url'] as String,
        headers:
            (json['headers'] as Map<dynamic, dynamic>).cast<String, String>(),
      );

  final String url;
  final Map<String, String> headers;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'url': url,
        'headers': headers,
      };
}
