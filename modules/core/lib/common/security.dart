import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class HttpClientCustom {
  static http.Client? _client;
  static http.Client get client => _client ??= http.Client();

  static init() async {
    _client = await instance;
  }

  static Future<http.Client> get instance async =>
      _client ??= await getIoClient();

  static Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  static Future<IOClient> getIoClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);

    return ioClient;
  }
}
