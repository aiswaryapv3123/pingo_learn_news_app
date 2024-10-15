import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  prepareHeader() {
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    return header;
  }

  Future<Response> post<E>(String url, Map<String, dynamic>? body) async {
    final header = prepareHeader();
    return await http.post(Uri.parse(url),
        body: jsonEncode(body), headers: header);
  }

  Future<Response> get<E>(String url) async {
    final header = prepareHeader();
    return await http.get(Uri.parse(url), headers: header);
  }
}
