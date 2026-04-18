// screens/search/post_search_delegate.dart
import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../widgets/post_card_base.dart';
import '../../theme/app_theme.dart';

class PostSearchDelegate extends SearchDelegate {
  final List<PostModel> allPosts;
  final Widget Function(PostModel) buildContent;

  PostSearchDelegate({required this.allPosts, required this.buildContent});

  // 1. Estilo del buscador (Dark)
  @override
  ThemeData appBarTheme(BuildContext context) {
    return AppTheme.darkTheme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppTheme.textSecondary),
      ),
    );
  }

  // 2. Acción para limpiar la búsqueda
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: AppTheme.textPrimary),
        onPressed: () => query = '',
      ),
    ];
  }

  // 3. Botón para cerrar el buscador
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
      onPressed: () => close(context, null),
    );
  }

  // 4. Resultados de la búsqueda
  @override
  Widget buildResults(BuildContext context) {
    final results = allPosts.where((post) {
      final searchTarget = "${post.userName} ${post.content} ${post.vehicleData?.brand ?? ''} ${post.vehicleData?.model ?? ''}".toLowerCase();
      return searchTarget.contains(query.toLowerCase());
    }).toList();

    return _buildList(results);
  }

  // 5. Sugerencias mientras escribes
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allPosts.where((post) {
      final searchTarget = "${post.vehicleData?.brand ?? ''} ${post.vehicleData?.model ?? ''}".toLowerCase();
      return searchTarget.contains(query.toLowerCase());
    }).toList();

    return _buildList(suggestions);
  }

  Widget _buildList(List<PostModel> list) {
    if (list.isEmpty) {
      return const Center(
        child: Text("No se encontraron resultados técnicos.", style: TextStyle(color: AppTheme.textSecondary)),
      );
    }

    return Container(
      color: AppTheme.darkBackground,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final post = list[index];
          return PostCardBase(
            post: post,
            contentWidget: buildContent(post),
          );
        },
      ),
    );
  }
}