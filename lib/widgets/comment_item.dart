// widgets/comment_item.dart
import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../theme/app_theme.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar más pequeño para respuestas técnicas
          CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.dividerColor,
            backgroundImage: comment.userPhotoUrl != null 
                ? NetworkImage(comment.userPhotoUrl!) 
                : null,
            child: comment.userPhotoUrl == null 
                ? const Icon(Icons.person, size: 18, color: AppTheme.textSecondary) 
                : null,
          ),
          const SizedBox(width: 12),
          
          // Cuerpo del comentario
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.userName,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // CORRECCIÓN: Se agrega 'const' para mejorar el rendimiento (Línea 47 original)
                    const Text(
                      "• 5h", // Tiempo relativo (Simulado)
                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                    ),
                  ],
                ),
                // CORRECCIÓN: Se agrega 'const' al espaciador (Línea 49 original)
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}