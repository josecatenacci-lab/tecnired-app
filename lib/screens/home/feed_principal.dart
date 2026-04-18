// screens/home/feed_principal.dart
import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../models/post_type.dart';
import '../../widgets/post_card_base.dart';
import '../../widgets/free_post_content.dart';
import '../../widgets/corte_content.dart';
import '../../widgets/diagrama_content.dart';
import '../../widgets/conexion_content.dart';

class FeedPrincipal extends StatelessWidget {
  final List<PostModel> posts;

  const FeedPrincipal({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const Center(
        child: Text(
          "No hay aportes técnicos disponibles",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: posts.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        final post = posts[index];

        return PostCardBase(
          post: post,
          usuario: post.userName,
          fecha: "Reciente", 
          titulo: post.type.displayName.toUpperCase(),
          // Se pasa el widget de contenido dinámico según el tipo de post
          contentWidget: _buildPostContent(post),
        );
      },
    );
  }

  /// Helper blindado para decidir qué mostrar según el tipo de aporte.
  /// Se eliminó el 'default' para cumplir con las reglas de exhaustividad de Dart.
  Widget _buildPostContent(PostModel post) {
    switch (post.type) {
      case PostType.corte:
        return CorteContent(post: post);
        
      case PostType.diagrama:
        return DiagramaContent(post: post);
        
      case PostType.conexion:
        return ConexionContent(post: post);
        
      case PostType.libre:
        return FreePostContent(post: post);
      
      // BLINDAJE: Si en el futuro agregas un PostType nuevo, 
      // el compilador te avisará aquí mismo que falta agregarlo.
    }
  }
}