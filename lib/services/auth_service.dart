// services/auth_service.dart
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'https://tecnired-api.onrender.com'; 

  AuthStatus _status = AuthStatus.checking;
  String? _token;
  String? _userId;
  String? _userName;

  AuthStatus get status => _status;
  String? get token => _token;
  String? get userId => _userId;
  String? get userName => _userName;

  /// --- LOGIN CON MODO DIAGNÓSTICO ---
  Future<bool> login(String email, String password) async {
    _status = AuthStatus.checking;
    notifyListeners();

    // Limpieza de datos para evitar errores de tipeo
    final String cleanEmail = email.trim().toLowerCase();
    final String cleanPass = password.trim();

    debugPrint("=== INICIANDO PRUEBA DE LOGIN ===");
    debugPrint("Enviando a: $_baseUrl/api/auth/login");
    debugPrint("Datos: {email: $cleanEmail, password: $cleanPass}");

    try {
      final url = Uri.parse('$_baseUrl/api/auth/login');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': cleanEmail,
          'password': cleanPass
        }),
      ).timeout(const Duration(seconds: 45));

      debugPrint("Respuesta del Servidor (Status): ${response.statusCode}");
      debugPrint("Respuesta del Servidor (Body): ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _token = data['token'];
        _userName = data['user']['name'];
        _userId = data['user']['email'];
        _status = AuthStatus.authenticated;
        
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }
    } on TimeoutException {
      debugPrint("ALERTA: El servidor en Render tardó demasiado (Timeout).");
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint("ERROR CRÍTICO EN CONEXIÓN: $e");
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  /// --- REGISTRO CON MODO DIAGNÓSTICO ---
  Future<bool> register(String email, String password, String name) async {
    _status = AuthStatus.checking;
    notifyListeners();

    final String cleanEmail = email.trim().toLowerCase();
    final String cleanName = name.trim();
    final String cleanPass = password.trim();

    debugPrint("=== INICIANDO PRUEBA DE REGISTRO ===");
    debugPrint("Datos: {name: $cleanName, email: $cleanEmail, password: $cleanPass}");

    try {
      final url = Uri.parse('$_baseUrl/api/auth/register');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': cleanName,
          'email': cleanEmail,
          'password': cleanPass
        }),
      ).timeout(const Duration(seconds: 45));

      debugPrint("Respuesta Registro (Status): ${response.statusCode}");
      debugPrint("Respuesta Registro (Body): ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _token = data['token'];
        _userName = data['user']['name'];
        _userId = data['user']['email'];
        _status = AuthStatus.authenticated;
        
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Error crítico en Registro: $e");
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> checkAuthStatus() async {
    _status = AuthStatus.checking;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void logout() {
    _token = null;
    _userId = null;
    _userName = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}