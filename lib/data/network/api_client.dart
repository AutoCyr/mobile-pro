import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {

  static const String baseUrl = "https://services.autocyr.com/api/";

  Future<http.Response> get({
    required String path,
    Map<String, String>? headers,
  }) async {
    return await http.get(Uri.parse(baseUrl+path), headers: headers);
  }

  Future<http.Response> post({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body
  }) async {
    return await http.post(Uri.parse(baseUrl+path), headers: headers, body: json.encode(body));
  }

  Future<http.Response> postMultipart({
    required String path,
    Map<String, String>? headers,
    required Map<String, String> body,
    required String filepath
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl+path))..fields.addAll(body)..headers.addAll(headers!)..files.add(
        await http.MultipartFile.fromPath('photo', filepath)
    );
    return await http.Response.fromStream(await request.send());
  }

  Future<http.Response> put({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body
  }) async {
    return await http.put(Uri.parse(baseUrl+path), headers: headers, body: json.encode(body));
  }

  Future<http.Response> delete({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body
  }) async {
    return await http.delete(Uri.parse(baseUrl+path), headers: headers, body: json.encode(body));
  }

}