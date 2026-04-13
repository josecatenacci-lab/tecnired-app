import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiClient {
  static const baseUrl = "https://tecnired-api.onrender.com";

  static Future<dynamic> get(String path) => _request("GET", path);
  static Future<dynamic> post(String path, Map body) => _request("POST", path, body: body);

  static Future _request(String method, String path, {Map? body}) async {
    final headers = {
      "Content-Type": "application/json",
      if (AuthService.instance.token != null) "Authorization": "Bearer ${AuthService.instance.token}"
    };
    final url = Uri.parse("$baseUrl$path");
    final res = method == "POST" 
      ? await http.post(url, headers: headers, body: jsonEncode(body))
      : await http.get(url, headers: headers);

    if (res.statusCode == 401) {
      if (await AuthService.instance.refresh()) return _request(method, path, body: body);
    }
    return jsonDecode(res.body);
  }
}