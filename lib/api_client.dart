import 'dart:convert';
import 'dart:async'; // Necesario para TimeoutException
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiClient {
  static const baseUrl = "https://tecnired-api.onrender.com";

  static Future<dynamic> get(String path, {bool isAuthRequest = false}) =>
      _request("GET", path, isAuthRequest: isAuthRequest);

  static Future<dynamic> post(
    String path,
    Map<String, dynamic> body, {
    bool isAuthRequest = false,
  }) =>
      _request("POST", path, body: body, isAuthRequest: isAuthRequest);

  static Future<dynamic> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
    bool retry = false,
    bool isAuthRequest = false,
  }) async {
    final headers = {
      "Content-Type": "application/json",
      if (!isAuthRequest && AuthService.instance.token != null)
        "Authorization": "Bearer ${AuthService.instance.token}"
    };

    final url = Uri.parse("$baseUrl$path");

    try {
      final http.Response res;
      
      if (method == "POST") {
        res = await http
            .post(
              url,
              headers: headers,
              body: jsonEncode(body),
            )
            .timeout(const Duration(seconds: 15));
      } else {
        res = await http
            .get(
              url,
              headers: headers,
            )
            .timeout(const Duration(seconds: 15));
      }

      // 🔄 Lógica de Silent Refresh
      if (res.statusCode == 401 && !retry && !isAuthRequest) {
        final ok = await AuthService.instance.refresh();
        if (ok) {
          // Reintento con el nuevo token
          return _request(method, path, body: body, retry: true);
        }
        // Si el refresh falla, AuthService ya habrá limpiado la sesión
        throw Exception("Sesión expirada");
      }

      if (res.statusCode >= 400) {
        // Intentamos extraer el mensaje de error del JSON del servidor si existe
        String errorMsg;
        try {
          final errorData = jsonDecode(res.body);
          errorMsg = errorData["message"] ?? "Error del servidor";
        } catch (_) {
          errorMsg = "Error ${res.statusCode}";
        }
        throw Exception(errorMsg);
      }

      // Evita error al decodificar si la respuesta está vacía
      return res.body.isNotEmpty ? jsonDecode(res.body) : null;

    } on TimeoutException {
      throw Exception("El servidor tarda demasiado en responder");
    } catch (e) {
      // Evitamos redundancia de "Exception: Error de red: Exception: ..."
      final cleanMsg = e.toString().replaceAll("Exception:", "").trim();
      throw Exception("Conexión: $cleanMsg");
    }
  }
}