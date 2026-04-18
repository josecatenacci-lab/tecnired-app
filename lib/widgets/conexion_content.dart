// widgets/conexion_content.dart
import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../theme/app_theme.dart';

class ConexionContent extends StatelessWidget {
  final PostModel post;

  const ConexionContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- BLOQUE DE IDENTIFICACIÓN TÉCNICA (EL ALMA) ---
        if (post.vehicleData != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.accentBlue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppTheme.accentBlue.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.settings_input_component_rounded,
                  color: AppTheme.accentBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${post.vehicleData!.brand} ${post.vehicleData!.model}".toUpperCase(),
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (post.vehicleData?.year != null && post.vehicleData!.year!.isNotEmpty)
                        Text(
                          "AÑO/VERSIÓN: ${post.vehicleData!.year}",
                          style: const TextStyle(
                            color: AppTheme.accentBlue,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 20),

        // --- ETIQUETA DE SECCIÓN INDUSTRIAL ---
        Row(
          children: [
            // CORREGIDO: 'electrical_services_rounded' en minúscula y sin const global
            const Icon(
              Icons.electrical_services_rounded, 
              color: AppTheme.textSecondary, 
              size: 18
            ),
            const SizedBox(width: 8),
            Text(
              "GUÍA DE CONEXIÓN Y ALIMENTACIÓN",
              style: TextStyle(
                color: AppTheme.textSecondary.withValues(alpha: 0.7),
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // --- CONTENEDOR DE INFORMACIÓN TÉCNICA ---
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border(
              left: BorderSide(
                color: AppTheme.accentBlue.withValues(alpha: 0.4), 
                width: 4
              ),
            ),
          ),
          child: Text(
            post.content,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 14,
              height: 1.6,
              letterSpacing: 0.3,
            ),
          ),
        ),

        // --- REFERENCIA VISUAL (SI EXISTE) ---
        if (post.images.isNotEmpty) ...[
          const SizedBox(height: 20),
          const Row(
            children: [
              Icon(Icons.camera_alt_outlined, size: 16, color: AppTheme.textSecondary),
              SizedBox(width: 8),
              Text(
                "EVIDENCIA DE INSTALACIÓN",
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 180,
              width: double.infinity,
              color: Colors.black26,
              child: const Center(
                child: Icon(Icons.photo_library_outlined, color: AppTheme.accentBlue, size: 32),
              ),
            ),
          ),
        ],

        const SizedBox(height: 15),
        const Divider(color: AppTheme.dividerColor, thickness: 1),
      ],
    );
  }
}