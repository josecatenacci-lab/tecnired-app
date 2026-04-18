// theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // 1. NUEVA PALETA DE COLORES - Estilo Facebook "White & Black"
  static const Color fbLightBg     = Color(0xFFF0F2F5); // Fondo gris claro
  static const Color pureWhite     = Color(0xFFFFFFFF); // Blanco para tarjetas
  static const Color accentBlack   = Color(0xFF080808); // Negro identidad
  static const Color accentRed     = Color(0xFFF02849); 
  static const Color accentGreen   = Color(0xFF45BD62); 
  static const Color textPrimary   = Color(0xFF050505); 
  static const Color textSecondary = Color(0xFF65676B); 
  static const Color fbDivider     = Color(0xFFCED0D4); 

  // --------------------------------------------------------------------------
  // 2. COMPATIBILIDAD (SOPORTE PARA TUS 147 ERRORES)
  // Re-definimos los nombres antiguos para que el compilador no falle.
  // --------------------------------------------------------------------------
  static const Color darkBackground = fbLightBg;   // Mapeado a claro
  static const Color darkSurface    = pureWhite;   // Mapeado a blanco
  static const Color dividerColor   = fbDivider;   // Mapeado a gris claro
  static const Color accentBlue     = accentBlack; // Tu antiguo "Azul" ahora es NEGRO
  // --------------------------------------------------------------------------

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: fbLightBg,
      
      // Cabecera estilo Facebook (Blanca)
      appBarTheme: const AppBarTheme(
        backgroundColor: pureWhite,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: accentBlack, 
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.2,
        ),
        iconTheme: IconThemeData(color: accentBlack, size: 24),
      ),

      // Configuración de las Tarjetas
      cardTheme: CardThemeData(
        color: pureWhite,
        elevation: 0, 
        clipBehavior: Clip.antiAlias, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), 
          side: const BorderSide(color: fbDivider, width: 0.5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      ),

      // Tipografía
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
        titleMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w600, fontSize: 16),
        bodyLarge: TextStyle(color: textPrimary, fontSize: 15),
        bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
        labelSmall: TextStyle(color: textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
      ),

      // Botones
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentBlack,
        foregroundColor: pureWhite,
        elevation: 4,
        shape: CircleBorder(), 
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fbLightBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: accentBlack, width: 1.0),
        ),
        hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBlack,
          foregroundColor: pureWhite,
          minimumSize: const Size(double.infinity, 45),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentBlack,
        brightness: Brightness.light,
        surface: pureWhite,
        onSurface: textPrimary,
        error: accentRed,
        outline: fbDivider,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: pureWhite,
        selectedItemColor: accentBlack,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }

  // BLINDAJE EXTRA: Si algún archivo llama a 'darkTheme', le devolvemos el light
  // para que la app no rompa y mantenga la nueva estética blanca.
  static ThemeData get darkTheme => lightTheme;
}