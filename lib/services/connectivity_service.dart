// services/connectivity_service.dart
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityService {
  // Controlador para el flujo del estado de conexión
  final StreamController<ConnectivityStatus> _controller = StreamController<ConnectivityStatus>.broadcast();

  Stream<ConnectivityStatus> get statusStream => _controller.stream;

  ConnectivityService() {
    // Chequeo periódico simple cada 5 segundos
    Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkStatus();
    });
  }

  Future<void> _checkStatus() async {
    try {
      // Intentamos contactar a Google o a tu API en Render para confirmar internet real
      final response = await http.get(Uri.parse('https://google.com')).timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        _controller.add(ConnectivityStatus.online);
      } else {
        _controller.add(ConnectivityStatus.offline);
      }
    } catch (_) {
      _controller.add(ConnectivityStatus.offline);
    }
  }

  // Utilidad para mostrar un aviso rápido (Snackbar) al técnico
  void showNoConnectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.white),
            SizedBox(width: 12),
            Text("Sin conexión a internet. Verifica tu señal."),
          ],
        ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void dispose() {
    _controller.close();
  }
}