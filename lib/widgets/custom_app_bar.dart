// widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String)? onSearch;
  final VoidCallback? onLogout;

  const CustomAppBar({
    super.key,
    this.onSearch,
    this.onLogout,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.pureWhite,
      elevation: 0,
      // El icono de la hamburguesa aparecerá automáticamente a la izquierda
      // gracias a que el Scaffold en HomeScreen tiene un 'drawer'.
      title: const Text(
        "TecniRed",
        style: TextStyle(
          color: AppTheme.accentBlack,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.0,
          fontSize: 26,
        ),
      ),
      actions: [
        // 1. Botón de Búsqueda
        IconButton(
          icon: const Icon(Icons.search, color: AppTheme.textPrimary),
          onPressed: () {
            if (onSearch != null) onSearch!("");
          },
        ),
        
        // 2. Botón de Notificaciones (Reemplaza a los 3 puntos)
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined, color: AppTheme.textPrimary),
              onPressed: () {
                debugPrint("Abriendo panel de notificaciones");
              },
            ),
            // Punto rojo de notificación (opcional, para dar realismo)
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppTheme.accentRed,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 8,
                  minHeight: 8,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(
          color: AppTheme.fbDivider,
          height: 0.5,
        ),
      ),
    );
  }
}