import 'package:flutter/material.dart';
import 'auth_service.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.user;
    final role = AuthService.instance.role;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tecnired Dashboard"),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            tooltip: "Cerrar Sesión",
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: () async => await AuthService.instance.logout(),
          )
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              color: Colors.grey.shade50, // Fondo suave para resaltar cards
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    // Perfil del Usuario
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.indigo.shade100,
                          child: const Icon(Icons.person, size: 70, color: Colors.indigo),
                        ),
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.check, size: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      user['nombre'] ?? 'Usuario',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Etiqueta de Rol
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        role.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Módulo exclusivo de Administrador
                    if (role == "admin")
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Colors.amber.shade400, width: 2),
                          ),
                          color: Colors.amber.shade50,
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.admin_panel_settings, size: 30, color: Colors.amber),
                                    SizedBox(width: 15),
                                    Text(
                                      "Gestiòn de Sistema",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 30),
                                Text(
                                  "Tienes acceso total para monitorear unidades y gestionar técnicos de campo.",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    
                    // Aquí podrías agregar más módulos para técnicos
                    if (role == "technician")
                      const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text("Panel de Operaciones en Terreno habilitado."),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}