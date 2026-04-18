// widgets/free_post_content.dart
import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../theme/app_theme.dart';

class FreePostContent extends StatelessWidget {
  final PostModel post;

  const FreePostContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Texto de la publicación
        Text(
          post.content,
          style: AppTheme.darkTheme.textTheme.bodyLarge,
        ),
        
        // Si hay imágenes, las mostramos (solo si la lista no está vacía)
        if (post.images.isNotEmpty) ...[
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                post.images[0], // Mostramos la primera imagen como principal
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppTheme.dividerColor,
                  child: const Icon(Icons.image_not_supported, color: AppTheme.textSecondary),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}