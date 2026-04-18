// services/storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Llaves privadas para evitar errores de dedo
  static const String _tokenKey = 'auth_token';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';

  // 1. Guardar el Token de Sesión
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // 2. Obtener el Token (Para inyectarlo en las peticiones API)
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // 3. Guardar datos del perfil básico
  Future<void> saveUserData({required String name, required String email}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
    await prefs.setString(_userEmailKey, email);
  }

  // 4. Obtener nombre del técnico para la UI
  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey) ?? 'Técnico';
  }

  // 5. Cerrar Sesión (Limpiar todo)
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}