// screens/home/post_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../models/post_type.dart';
import '../../theme/app_theme.dart';
import '../../widgets/corte_content.dart';
import '../../widgets/diagrama_content.dart';
import '../../widgets/conexion_content.dart';
import '../../widgets/free_post_content.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkSurface,
        elevation: 0,
        title: Text(
          post.type.displayName.toUpperCase(),
          style: const TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            letterSpacing: 1.2,
            color: AppTheme.accentBlue,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner superior informativo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.darkSurface.withValues(alpha: 0.5),
                border: const Border(
                  bottom: BorderSide(color: AppTheme.dividerColor, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppTheme.accentBlue,
                    child: Icon(Icons.engineering, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.userName,
                          style: const TextStyle(
                            color: AppTheme.textPrimary, 
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Técnico Colaborador • ${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}",
                          style: const TextStyle(
                            color: AppTheme.textSecondary, 
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Contenido Técnico Específico
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: _buildSpecificContent(post),
            ),

            const SizedBox(height: 20),

            // Pie de página / Comentarios Placeholder
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: AppTheme.dividerColor, thickness: 1),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.forum_outlined, color: AppTheme.textSecondary, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    "COMENTARIOS TÉCNICOS",
                    style: TextStyle(
                      color: AppTheme.textSecondary.withValues(alpha: 0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            
            // Espacio inferior para que el contenido no pegue con el borde
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// Helper blindado para renderizar el widget correcto.
  /// Se eliminó 'default' para que sea exhaustivo según el enum PostType.
  Widget _buildSpecificContent(PostModel post) {
    switch (post.type) {
      case PostType.corte:
        return CorteContent(post: post);
      case PostType.diagrama:
        return DiagramaContent(post: post);
      case PostType.conexion:
        return ConexionContent(post: post);
      case PostType.libre:
        return FreePostContent(post: post);
    }
  }
}