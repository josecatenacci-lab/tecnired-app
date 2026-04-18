// screens/home/tabs/cortes_tab.dart
import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CortesTab extends StatelessWidget {
  const CortesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Buscador superior interno
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Buscar marca o modelo (ej. Toyota Hilux)",
              prefixIcon: const Icon(Icons.search, color: AppTheme.accentBlack),
              filled: true,
              fillColor: AppTheme.pureWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Lista de diagramas
        Expanded(
          child: ListView.builder(
            itemCount: 5, // Temporal para pruebas
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              return _buildVehicleCard(
                brand: "Toyota",
                model: "Hilux Revo",
                year: "2022-2024",
                description: "Corte de bomba de combustible - Conector bajo asiento piloto.",
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleCard({
    required String brand,
    required String model,
    required String year,
    required String description,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.fbLightBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.directions_car, color: AppTheme.accentBlack),
        ),
        title: Text("$brand $model", style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Año: $year"),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Procedimiento Técnico:", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(description),
                const SizedBox(height: 15),
                // Simulación de imagen del diagrama
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.fbDivider),
                  ),
                  child: const Center(
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.fullscreen),
                  label: const Text("Ver Diagrama Completo"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentBlack,
                    foregroundColor: AppTheme.pureWhite,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}