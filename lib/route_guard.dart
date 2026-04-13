import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';

class RouteGuard {
  static Widget protect(Widget page, {List<String>? roles}) {
    final auth = AuthService.instance;

    // 1. Verificación de sesión
    if (!auth.isLoggedIn) {
      return const LoginScreen();
    }

    // 2. Verificación de Roles (RBAC)
    if (roles != null && roles.isNotEmpty) {
      final userRole = auth.role;

      // Comparamos el rol actual contra la lista de permitidos
      if (!roles.contains(userRole)) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Acceso restringido"),
            centerTitle: true,
            // Quitamos el botón de atrás para evitar navegación inconsistente
            automaticallyImplyLeading: false, 
          ),
          body: Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_person_rounded, size: 100, color: Colors.indigo),
                    const SizedBox(height: 24),
                    const Text(
                      "Módulo Restringido",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Tu perfil actual tiene el rol: '${userRole.toUpperCase()}'.\nNo tienes los permisos necesarios para ver esta sección.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () => auth.logout(),
                        icon: const Icon(Icons.logout_rounded),
                        label: const Text("CERRAR SESIÓN Y VOLVER"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

    return page;
  }
}