// screens/home/tabs/search_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_theme.dart';
import '../../../services/post_service.dart';
import '../../../widgets/post_card_base.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    // Escuchamos el servicio de posts para obtener la lista actualizada
    final postService = context.watch<PostService>();

    // BLINDAJE: Filtrado local instantáneo con seguridad ante nulos
    final filteredPosts = postService.posts.where((post) {
      if (_query.isEmpty) return true;
      
      final searchLower = _query.toLowerCase();
      
      // Verificamos marca, modelo y contenido técnico
      final brand = post.vehicleData?.brand.toLowerCase() ?? '';
      final model = post.vehicleData?.model.toLowerCase() ?? '';
      final content = post.content.toLowerCase();
      
      return brand.contains(searchLower) || 
             model.contains(searchLower) || 
             content.contains(searchLower);
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkSurface,
        elevation: 0,
        title: TextField(
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: const InputDecoration(
            hintText: "Buscar por marca, modelo o cable...",
            hintStyle: TextStyle(color: Colors.white24, fontSize: 14),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: AppTheme.accentBlue),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _query = value;
            });
          },
        ),
      ),
      body: Column(
        children: [
          // Barra de progreso si el servicio está cargando datos del servidor
          if (postService.isLoading)
            const LinearProgressIndicator(
              backgroundColor: AppTheme.darkSurface, 
              color: AppTheme.accentBlue,
              minHeight: 2,
            ),
          
          Expanded(
            child: filteredPosts.isEmpty
                ? _buildEmptySearch()
                : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      final post = filteredPosts[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: PostCardBase(
                          post: post,
                          usuario: post.userName,
                          fecha: "Resultado",
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
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentBlue,
        tooltip: "Actualizar base de datos",
        child: const Icon(Icons.refresh, color: Colors.white),
        onPressed: () {
          // El servicio ya gestiona el token internamente
          postService.fetchPosts(); 
        },
      ),
    );
  }

  Widget _buildEmptySearch() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.manage_search_rounded, 
              size: 80, 
              color: AppTheme.textSecondary.withValues(alpha: 0.2)
            ),
            const SizedBox(height: 16),
            const Text(
              "No se encontraron diagramas o cortes",
              style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              "Intenta con términos más generales",
              style: TextStyle(color: Colors.white24, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}