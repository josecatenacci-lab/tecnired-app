// services/notification_service.dart
import 'package:flutter/foundation.dart'; // Necesario para debugPrint
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Configuración para Android (Asegúrate de que ic_launcher exista en res/mipmap)
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        // CORRECCIÓN: Se usa debugPrint en lugar de print para producción
        debugPrint("TecniRed Log: Notificación tocada con payload: ${details.payload}");
        
        // Aquí puedes implementar el Router para navegar:
        // if (details.payload != null) { ... }
      },
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    await _notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'tecnired_channel',
          'Alertas TecniRed',
          channelDescription: 'Notificaciones sobre aportes y comentarios',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          // Es vital que el icono aquí coincida con el de la inicialización
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: payload,
    );
  }
}