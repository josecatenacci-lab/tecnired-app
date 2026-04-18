// screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Perfil Técnico"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {}, // Configuración de cuenta
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // 1. Cabecera de Perfil
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.dividerColor,
              child: Icon(Icons.person, size: 50, color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 16),
            const Text(
              "Jose C.", // Aquí vendrá el nombre del AuthService
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
            ),
            const Text(
              "Especialista en GPS y Telemetría",
              style: TextStyle(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 24),

            // 2. Estadísticas de Aportes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn("Aportes", "24"),
                _buildStatColumn("Reputación", "150"),
                _buildStatColumn("Siguiendo", "12"),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: AppTheme.dividerColor),

            // 3. Pestañas de Mis Publicaciones
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mis Publicaciones Recientes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            // Aquí se reutilizarían las PostCards que ya creamos
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  "Aún no has realizado aportes técnicos.",
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.accentBlue)),
        Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
      ],
    );
  }
}