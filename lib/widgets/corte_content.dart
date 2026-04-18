// widgets/corte_content.dart
import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../theme/app_theme.dart';

class CorteContent extends StatelessWidget {
  final PostModel post; // Recibe el modelo completo

  const CorteContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Información del Vehículo (Si existe)
        if (post.vehicleData != null) ...[
          Row(
            children: [
              const Icon(Icons.directions_car, size: 18, color: AppTheme.accentBlue),
              const SizedBox(width: 8),
              Text(
                "${post.vehicleData!.brand} ${post.vehicleData!.model}",
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],

        // Descripción del Corte
        const Text(
          "INSTRUCCIONES DE CORRETE/BLOQUEO:",
          style: TextStyle(
            color: AppTheme.accentBlue,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          post.content, // Usamos el contenido principal del post
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        ),
        
        // Si hay imágenes guardadas, aquí se podrían mostrar en un carrusel o grid
        if (post.images.isNotEmpty) ...[
          const SizedBox(height: 15),
          const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Divider(color: AppTheme.dividerColor), // Espaciador visual
          ),
        ],
      ],
    );
  }
}