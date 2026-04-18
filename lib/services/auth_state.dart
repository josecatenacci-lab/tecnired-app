// services/auth_state.dart
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState extends ChangeNotifier {
  AuthStatus _status = AuthStatus.checking;
  String? _token;
  String? _userId;

  AuthStatus get status => _status;
  String? get token => _token;
  String? get userId => _userId;

  // Constructor: Aquí podríamos disparar la verificación de un token guardado
  AuthState() {
    checkToken();
  }

  // Simula la verificación inicial (luego conectará con almacenamiento local)
  Future<void> checkToken() async {
    _status = AuthStatus.checking;
    notifyListeners();

    // Lógica para leer el token (por ahora simulamos que no hay uno)
    await Future.delayed(const Duration(seconds: 1));
    _status = AuthStatus.notAuthenticated;
    notifyListeners();
  }

  // Método para cuando el login sea exitoso
  void login(String token, String userId) {
    _token = token;
    _userId = userId;
    _status = AuthStatus.authenticated;
    notifyListeners(); // Avisa a toda la app para que cambie al Home
  }

  // Método para el botón de "Salida" que definimos en el AppBar
  void logout() {
    _token = null;
    _userId = null;
    _status = AuthStatus.notAuthenticated;
    notifyListeners(); // Avisa a toda la app para que vuelva al Login
  }
}