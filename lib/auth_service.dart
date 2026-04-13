import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';
import 'auth_state.dart';

class AuthService {
  static final instance = AuthService._();
  AuthService._();

  String? _accessToken;
  String? _refreshToken;
  Map<String, dynamic>? _user;

  String? get token => _accessToken;
  Map<String, dynamic>? get user => _user;
  String get role => _user?["role"] ?? "guest";
  bool get isLoggedIn => _accessToken != null;

  // 🔐 LOGIN: Autentica y notifica a la UI
  Future<bool> login(String email, String password) async {
    try {
      final res = await ApiClient.post(
        "/auth/login",
        {"email": email, "password": password},
        isAuthRequest: true,
      );

      if (res == null || res["access_token"] == null) return false;

      _accessToken = res["access_token"];
      _refreshToken = res["refresh_token"];

      await _save();
      await loadProfile();

      AuthState.instance.notify(); 
      return true;
    } catch (e) {
      return false;
    }
  }

  // 👤 PROFILE: Obtiene datos del usuario actual
  Future<void> loadProfile() async {
    try {
      final res = await ApiClient.get("/auth/me");
      if (res != null && res["role"] != null) {
        _user = res;
      } else {
        await logout();
      }
    } catch (e) {
      await logout();
    }
  }

  // 🔄 REFRESH TOKEN: Renovación automática de sesión
  Future<bool> refresh() async {
    if (_refreshToken == null) return false;
    try {
      final res = await ApiClient.post(
        "/auth/refresh",
        {"refresh_token": _refreshToken},
        isAuthRequest: true,
      );

      if (res == null || res["access_token"] == null) return false;

      _accessToken = res["access_token"];
      await _save();
      return true;
    } catch (e) {
      await logout();
      return false;
    }
  }

  // 💾 RESTORE SESSION: Se ejecuta al abrir la App
  Future<void> loadSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _accessToken = prefs.getString("access");
      _refreshToken = prefs.getString("refresh");

      if (isLoggedIn) {
        await loadProfile();
      }
    } catch (e) {
      await logout();
    }
    AuthState.instance.notify();
  }

  // 🚪 LOGOUT: Limpieza total
  Future<void> logout() async {
    _accessToken = null;
    _refreshToken = null;
    _user = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Borra todo de forma segura

    AuthState.instance.notify();
  }

  // 💾 SAVE TOKENS: Persistencia local
  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    if (_accessToken != null) await prefs.setString("access", _accessToken!);
    if (_refreshToken != null) await prefs.setString("refresh", _refreshToken!);
  }
}