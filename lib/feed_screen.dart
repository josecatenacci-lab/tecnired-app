import 'package:flutter/material.dart';
import 'auth_service.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enterprise GPS"),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () => AuthService.instance.logout())],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Usuario: ${user?['nombre'] ?? ''}", style: const TextStyle(fontSize: 18)),
            Text("Rol: ${AuthService.instance.role.toUpperCase()}"),
            if (AuthService.instance.role == "admin") 
              const Card(color: Colors.amber, child: Padding(padding: EdgeInsets.all(10), child: Text("🔐 PANEL ADMINISTRADOR"))),
          ],
        ),
      ),
    );
  }
}