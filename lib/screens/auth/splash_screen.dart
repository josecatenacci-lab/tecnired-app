// screens/auth/splash_screen.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    // Tiempo de carga para mostrar el logo y la versión
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      body: Stack( // Usamos Stack para posicionar la versión al fondo
        children: [
          // CONTENIDO CENTRAL (Logo y Spinner)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 180, 
                  height: 180,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.settings_input_antenna,
                    size: 100,
                    color: AppTheme.accentBlack,
                  ),
                ),
                const SizedBox(height: 30),
                const CircularProgressIndicator(
                  color: AppTheme.accentBlack,
                  strokeWidth: 2, // Más fino para un look más técnico
                ),
              ],
            ),
          ),

          // NÚMERO DE VERSIÓN (Posicionado al final)
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0), // Espacio desde el borde inferior
              child: Text(
                "Versión 3.1.2.3",
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                  fontFamily: 'monospace', // Estilo de consola técnica
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}