// services/api_client.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  // -------------------------------------------------------------------------
  // ¡IMPORTANTE! CONFIGURACIÓN DE PRODUCCIÓN
  // Cambia 'localhost' por tu URL real de Render.
  // Ejemplo: "https://tecnired-api.onrender.com/api"
  // -------------------------------------------------------------------------
  static const String baseUrl = "https://tecnired-api.onrender.com";

  // Blindaje para incluir el Token JWT automáticamente en cada petición
  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Método POST Blindado
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    
    return await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  // Método GET Blindado
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    
    return await http.get(url, headers: headers);
  }
}