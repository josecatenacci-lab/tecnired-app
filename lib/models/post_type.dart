// models/post_type.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum PostType { corte, diagrama, conexion, libre }

extension PostTypeExtension on PostType {
  // 1. Nombres para mostrar en la interfaz (Resuelve el error en post_card_base)
  String get displayName {
    switch (this) {
      case PostType.corte:
        return 'Corte de Corriente';
      case PostType.diagrama:
        return 'Diagrama Eléctrico';
      case PostType.conexion:
        return 'Puntos de Conexión';
      case PostType.libre:
        return 'Aporte Libre';
    }
  }

  // 2. Iconos oficiales de Material Design
  IconData get icon {
    switch (this) {
      case PostType.corte:
        return Icons.content_cut_rounded; // Representación técnica de corte
      case PostType.diagrama:
        return Icons.schema_rounded;      // Representación de esquema/diagrama
      case PostType.conexion:
        return Icons.settings_input_component_rounded; // Conector físico
      case PostType.libre:
        return Icons.forum_rounded;       // Icono de conversación/comunidad
    }
  }

  // 3. Colores técnicos (Resuelve el error en post_card_base)
  Color get color {
    switch (this) {
      case PostType.corte:
        // Asegúrate de que accentRed esté definido en AppTheme, si no, usa Colors.redAccent
        return AppTheme.accentRed; 
      case PostType.diagrama:
        return AppTheme.accentBlue;
      case PostType.conexion:
        return AppTheme.accentGreen;
      case PostType.libre:
        return Colors.purpleAccent;
    }
  }
}