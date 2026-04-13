import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_state.dart';

class AuthService {
  static final instance = AuthService._internal();
  AuthService._internal();

  String? _accessToken;
  String? _refreshToken;
  Map<String, dynamic>? _user;

  String? get token => _accessToken;
  Map<String, dynamic>? get user => _user;
  String get role => _user?["role"] ?? "guest";
  bool get isLoggedIn => _accessToken != null;

 static const baseUrl = "https://tecnired-api.onrender.com";

  Future<bool> login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    if (res.statusCode != 200) return false;
    final data = jsonDecode(res.body);
    _accessToken = data["access_token"];
    _refreshToken = data["refresh_token"];
    await _save();
    await fetchProfile();
    AuthState.instance.notify();
    return true;
  }

  Future<void> fetchProfile() async {
    final res = await http.get(Uri.parse("$baseUrl/auth/me"),
      headers: {"Authorization": "Bearer $_accessToken"});
    if (res.statusCode == 200) {
      _user = jsonDecode(res.body);
    } else { await logout(); }
  }

  Future<bool> refresh() async {
    final res = await http.post(Uri.parse("$baseUrl/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refresh_token": _refreshToken}));
    if (res.statusCode != 200) return false;
    _accessToken = jsonDecode(res.body)["access_token"];
    await _save();
    return true;
  }

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString("access");
    _refreshToken = prefs.getString("refresh");
    if (isLoggedIn) await fetchProfile();
    AuthState.instance.notify();
  }

  Future<void> logout() async {
    _accessToken = _refreshToken = _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    AuthState.instance.notify();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("access", _accessToken!);
    await prefs.setString("refresh", _refreshToken!);
  }
}