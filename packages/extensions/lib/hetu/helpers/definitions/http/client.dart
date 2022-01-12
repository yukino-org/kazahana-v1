import 'dart:io';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class HttpClientOptions {
  const HttpClientOptions({
    required final this.ignoreSSLCertificate,
  });

  final bool ignoreSSLCertificate;
}

abstract class HetuHttpClient {
  static late Client client;
  static late HttpClientOptions options;

  static void initialize(final HttpClientOptions options) {
    final HttpClient client = HttpClient();

    if (options.ignoreSSLCertificate) {
      client.badCertificateCallback =
          (final X509Certificate cert, final String host, final int port) =>
              true;
    }

    HetuHttpClient.client = IOClient(client);
  }
}
