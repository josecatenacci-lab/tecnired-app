// screens/notifications/notifications_screen.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        title: const Text(
          "NOTIFICACIONES",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.darkSurface,
        elevation: 0,
        // Agregamos un leading para asegurar que pueda volver atrás si no es un tab
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(
          color: AppTheme.dividerColor, 
          height: 1,
          indent: 70,
        ),
        itemBuilder: (context, index) {
          return _buildNotificationItem(context, index);
        },
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, int index) {
    final isComment = index % 2 == 0;
    final bool isUnread = index < 3;

    return Container(
      color: isUnread 
          ? AppTheme.accentBlue.withValues(alpha: 0.05) 
          : Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.darkSurface,
              radius: 25,
              child: Icon(
                isComment ? Icons.chat_bubble_outline : Icons.thumb_up_off_alt,
                color: isComment ? AppTheme.accentBlue : Colors.orangeAccent,
                size: 22,
              ),
            ),
            if (isUnread)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: AppTheme.accentBlue,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.darkBackground, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: RichText(
          text: TextSpan(
            style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14),
            children: [
              const TextSpan(
                text: "Técnico Máster ", 
                style: TextStyle(fontWeight: FontWeight.bold)
              ),
              TextSpan(
                text: isComment 
                    ? "comentó tu diagrama de Toyota Hilux." 
                    : "reaccionó a tu aporte técnico sobre GPS.",
              ),
            ],
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            "Hace ${index + 2} min", 
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)
          ),
        ),
        onTap: () {
          // BLINDAJE: debugPrint en lugar de print
          debugPrint("Navegando a la notificación técnica: $index");
        },
      ),
    );
  }
}