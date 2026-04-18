// widgets/diagrama_content.dart
import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../theme/app_theme.dart';

class DiagramaContent extends StatelessWidget {
  final PostModel post;

  const DiagramaContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bloque de Identificación del Vehículo (Mantiene el diseño original)
        if (post.vehicleData != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.accentBlue.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.hub_outlined, color: AppTheme.accentBlue, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      "${post.vehicleData!.brand} ${post.vehicleData!.model}".toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
                if (post.vehicleData?.year != null && post.vehicleData!.year!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 30),
                    child: Text(
                      "Año/Versión: ${post.vehicleData!.year}",
                      style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        
        const SizedBox(height: 16),

        // Sección de Especificaciones Técnicas
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: AppTheme.accentBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "DIAGRAMA Y ESPECIFICACIONES",
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),

        // Cuerpo del mensaje / Instrucciones
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppTheme.darkSurface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            post.content,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),

        // Área de Visualización de Diagrama (Placeholder para imágenes)
        if (post.images.isNotEmpty) ...[
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.black26,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_aspect_ratio, color: AppTheme.accentBlue, size: 40),
                    SizedBox(height: 8),
                    Text(
                      "Diagrama Técnico Adjunto",
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        
        const SizedBox(height: 8),
        const Divider(color: AppTheme.dividerColor, thickness: 1),
      ],
    );
  }
}