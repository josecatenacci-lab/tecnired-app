// widgets/image_preview_widget.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ImagePreviewWidget extends StatelessWidget {
  final File image;
  final VoidCallback onRemove;

  const ImagePreviewWidget({
    super.key,
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. La imagen con estilo Dark
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.dividerColor),
            image: DecorationImage(
              image: FileImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        // 2. Botón de eliminar (X)
        Positioned(
          top: 15,
          right: 10,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}