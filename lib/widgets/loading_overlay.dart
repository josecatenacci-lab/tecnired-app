// widgets/loading_overlay.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // La pantalla normal siempre en el fondo
        
        if (isLoading) ...[
          // Usamos un IgnorePointer para que el usuario no pueda interactuar 
          // con lo que hay debajo mientras carga
          const IgnorePointer(
            ignoring: true,
            child: SizedBox.expand(),
          ),
          
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), // Efecto de desenfoque técnico
            child: Container(
              // CORRECCIÓN: Se usa .withValues para evitar avisos de deprecación en Flutter 3.33+
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: AppTheme.accentBlue,
                      strokeWidth: 3,
                    ),
                    if (message != null) ...[
                      const SizedBox(height: 20),
                      Text(
                        message!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}