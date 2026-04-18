// widgets/custom_bottom_sheet.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomBottomSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const CustomBottomSheet({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppTheme.darkBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Barra estética superior
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.dividerColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Seleccionar origen",
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Opción: Cámara
          ListTile(
            leading: const Icon(Icons.camera_alt, color: AppTheme.accentBlue),
            title: const Text("Cámara", style: TextStyle(color: AppTheme.textPrimary)),
            subtitle: const Text("Tomar foto del diagrama ahora", style: TextStyle(color: AppTheme.textSecondary)),
            onTap: () {
              Navigator.pop(context);
              onCameraTap();
            },
          ),
          
          // Opción: Galería
          ListTile(
            leading: const Icon(Icons.photo_library, color: AppTheme.accentBlue),
            title: const Text("Galería", style: TextStyle(color: AppTheme.textPrimary)),
            subtitle: const Text("Elegir imagen de la galería", style: TextStyle(color: AppTheme.textSecondary)),
            onTap: () {
              Navigator.pop(context);
              onGalleryTap();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}