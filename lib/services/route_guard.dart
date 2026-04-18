// services/route_guard.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

class RouteGuard {
  /// Verifica si el usuario tiene permiso para acceder a una ruta.
  /// Si no está autenticado, lo redirige al login.
  static Widget check(BuildContext context, Widget screen) {
    final authService = Provider.of<AuthService>(context, listen: false);

    // CORREGIDO: Usamos el estado centralizado de nuestro AuthService
    if (authService.status == AuthStatus.authenticated) {
      return screen;
    } else {
      // Si está en 'checking' o 'unauthenticated', mandamos a login
      // Usamos un Future.microtask para evitar errores de construcción de frames
      Future.microtask(() {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
      
      // Retornamos un placeholder mientras se hace la redirección
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}