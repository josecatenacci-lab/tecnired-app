import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';

class RouteGuard {
  static Widget protect(Widget page, {List<String>? roles}) {
    if (!AuthService.instance.isLoggedIn) return const LoginScreen();
    if (roles != null && !roles.contains(AuthService.instance.role)) {
      return const Scaffold(body: Center(child: Text("⛔ Acceso Denegado")));
    }
    return page;
  }
}