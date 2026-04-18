// widgets/post_type_selector.dart
import 'package:flutter/material.dart';
import '../models/post_type.dart';
import '../theme/app_theme.dart';

class PostTypeSelector extends StatelessWidget {
  final PostType selectedType;
  final Function(PostType) onTypeSelected;

  const PostTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: PostType.values.length,
        itemBuilder: (context, index) {
          final type = PostType.values[index];
          final isSelected = selectedType == type;

          return GestureDetector(
            onTap: () => onTypeSelected(type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 100,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                // CORREGIDO: Usamos el getter .color del modelo
                color: isSelected 
                    ? type.color.withValues(alpha: 0.15) 
                    : AppTheme.darkSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? type.color : AppTheme.dividerColor,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CORREGIDO: Usamos el getter .icon del modelo
                  Icon(
                    type.icon,
                    color: isSelected ? type.color : AppTheme.textSecondary,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    type.displayName.split(' ').last, // Solo la última palabra para ahorrar espacio
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.textSecondary,
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}