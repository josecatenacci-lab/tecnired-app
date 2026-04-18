// screens/home/tabs/herramientas_tab.dart
import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class HerramientasTab extends StatelessWidget {
  const HerramientasTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos las herramientas con const para mayor rendimiento
    const List<Map<String, dynamic>> herramientas = [
      {'nombre': 'Diagramas', 'icon': Icons.account_tree_outlined},
      {'nombre': 'Sistemas', 'icon': Icons.settings_input_component},
      {'nombre': 'Pinouts', 'icon': Icons.electrical_services},
      {'nombre': 'Ubicaciones', 'icon': Icons.location_on_outlined},
      {'nombre': 'Manuales', 'icon': Icons.menu_book_outlined},
      {'nombre': 'Calculadora', 'icon': Icons.calculate_outlined},
    ];

    return Scaffold(
      backgroundColor: AppTheme.fbLightBg,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Biblioteca Técnica",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Recursos y utilidades de consulta rápida",
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 20),
            
            // Grid de herramientas
            Expanded(
              child: GridView.builder(
                // Se agregó const al delegate para optimizar
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemCount: herramientas.length,
                itemBuilder: (context, index) {
                  final item = herramientas[index];
                  return _buildToolCard(
                    item['nombre'] as String, 
                    item['icon'] as IconData
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget de tarjeta optimizado y blindado
  Widget _buildToolCard(String title, IconData icon) {
    return InkWell(
      borderRadius: BorderRadius.circular(12), // Para que el efecto visual no se salga de las esquinas
      onTap: () => debugPrint("Abriendo $title"),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: AppTheme.pureWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppTheme.fbDivider, width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration( // Agregado const para evitar info de analyze
                color: AppTheme.fbLightBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: AppTheme.accentBlack),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}