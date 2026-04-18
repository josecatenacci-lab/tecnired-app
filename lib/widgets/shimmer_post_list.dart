// widgets/shimmer_post_list.dart
import 'package:flutter/material.dart';
import 'shimmer_loading.dart';
import '../theme/app_theme.dart';

class ShimmerPostList extends StatelessWidget {
  const ShimmerPostList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Mostramos 5 publicaciones fantasma
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Container(
          // CORRECCIÓN: EdgeInsets.bottom(20) no existe, se usa EdgeInsets.only
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            // CORRECCIÓN: .withValues en lugar de .withOpacity para cumplir con Flutter 3.33+
            color: AppTheme.darkSurface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Cabecera (Avatar y Nombre)
              const Row(
                children: [
                  ShimmerLoading(height: 40, width: 40, borderRadius: 20),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerLoading(height: 12, width: 120),
                      SizedBox(height: 6),
                      ShimmerLoading(height: 10, width: 80),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // 2. Cuerpo del Post (Texto)
              const ShimmerLoading(height: 12, width: double.infinity),
              const SizedBox(height: 8),
              const ShimmerLoading(height: 12, width: 200),
              const SizedBox(height: 16),
              
              // 3. Espacio de Imagen (Diagrama/Corte)
              const ShimmerLoading(height: 180, width: double.infinity),
              const SizedBox(height: 16),
              
              // 4. Botones de interacción
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) => 
                  const ShimmerLoading(height: 30, width: 80, borderRadius: 8)
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}