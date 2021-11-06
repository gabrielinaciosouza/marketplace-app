import 'dart:convert';

import 'package:http/http.dart';
import 'package:marketplace_app/data/data.dart';

import '../infra.dart';

class HttpAdapter implements HttpClient {
  final Client _client;

  const HttpAdapter(this._client);
  @override
  Future<Map<String, dynamic>?> get(
      {required String url, Map<String, String>? headers}) async {
    final result = await _client.get(Uri.parse(url), headers: headers);

    if (result.statusCode != 200) throw const HttpServerError();

    return jsonDecode(result.body);
  }
}
