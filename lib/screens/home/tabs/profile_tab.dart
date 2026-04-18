// screens/home/tabs/profile_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_theme.dart';
import '../../../services/auth_service.dart';
import '../../../services/post_service.dart';
import '../../../widgets/post_card_base.dart';
// CORRECCIÓN: Se eliminó el import de post_model.dart porque no se usaba explícitamente aquí (Warning resuelto)

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos los servicios
    final authService = context.watch<AuthService>();
    final postService = context.watch<PostService>();

    // Filtramos los posts que pertenecen a este usuario
    final userPosts = postService.posts.where(
      (p) => p.userId == authService.userId
    ).toList();

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Cabecera del Perfil Técnico
          SliverToBoxAdapter(
            child: _buildProfileHeader(authService),
          ),

          // Lista de Aportes del Usuario
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            sliver: userPosts.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          "Aún no has realizado aportes técnicos.",
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = userPosts[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: PostCardBase(
                            post: post,
                            usuario: post.userName,
                            fecha: "Mi Aporte",
                            titulo: post.type.name.toUpperCase(),
                            contentWidget: Text(
                              post.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: AppTheme.textSecondary),
                            ),
                          ),
                        );
                      },
                      childCount: userPosts.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(AuthService auth) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: AppTheme.darkSurface,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // CORRECCIÓN: Se agregó const para mejorar performance
          const CircleAvatar(
            radius: 50,
            backgroundColor: AppTheme.accentBlue,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 15),
          const Text(
            "TÉCNICO ESPECIALISTA", 
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              // Uso de withValues para blindaje v3.33+
              color: AppTheme.accentBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            // CORRECCIÓN: Se agregó const (Línea 93 original)
            child: const Text(
              "Nivel 1: Instalador",
              style: TextStyle(color: AppTheme.accentBlue, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}