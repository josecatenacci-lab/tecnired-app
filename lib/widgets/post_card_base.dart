// widgets/post_card_base.dart
import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../models/post_type.dart'; // IMPORTANTE: Aquí debe estar la extensión del enum
import '../theme/app_theme.dart';

class PostCardBase extends StatelessWidget {
  final PostModel post;
  final Widget contentWidget;
  
  final String? usuario;
  final String? fecha;
  final String? titulo;
  final String? categoria;
  final VoidCallback? onTap;

  const PostCardBase({
    super.key,
    required this.post,
    required this.contentWidget,
    this.usuario,
    this.fecha,
    this.titulo,
    this.categoria,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppTheme.darkSurface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Encabezado
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.dividerColor,
                    backgroundImage: post.userPhotoUrl != null 
                        ? NetworkImage(post.userPhotoUrl!) 
                        : null,
                    child: post.userPhotoUrl == null 
                        ? const Icon(Icons.person, color: AppTheme.textSecondary) 
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usuario ?? post.userName, 
                          style: const TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 15
                          )
                        ),
                        Text(
                          // Aquí se usan los getters definidos en la extensión de PostType
                          "${post.type.displayName} • ${fecha ?? 'Ahora'}", 
                          style: TextStyle(
                            color: post.type.color, 
                            fontSize: 11, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz, color: AppTheme.textSecondary),
                ],
              ),
              const SizedBox(height: 12),

              // 2. Texto del Post
              if (titulo != null || post.content.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    titulo ?? post.content,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              // 3. Contenido Dinámico
              contentWidget,

              const SizedBox(height: 12),
              const Divider(color: AppTheme.dividerColor, height: 1),

              // 4. Botones de Acción
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ActionButton(icon: Icons.thumb_up_off_alt, label: "${post.likes}"),
                    _ActionButton(icon: Icons.chat_bubble_outline, label: "${post.commentsCount}"),
                    const _ActionButton(icon: Icons.share_outlined, label: "Compartir"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppTheme.textSecondary),
        const SizedBox(width: 5),
        Text(
          label, 
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)
        ),
      ],
    );
  }
}