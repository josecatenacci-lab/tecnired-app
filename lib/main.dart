// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:provider/provider.dart';

// Importaciones de configuración y estilo
import 'theme/app_theme.dart';
import 'services/auth_service.dart'; 
import 'services/post_service.dart';

// Importaciones de pantallas
import 'screens/login/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/create_post_screen.dart';

void main() async {
  // Garantiza que los servicios de Flutter estén listos antes de ejecutar la app
  WidgetsFlutterBinding.ensureInitialized();

  // BLINDAJE VISUAL: Configuración de la barra de estado y navegación
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // Iconos negros para fondo claro
    statusBarBrightness: Brightness.light,    // Necesario para compatibilidad en iOS
    systemNavigationBarColor: AppTheme.fbLightBg,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Bloquear orientación en vertical para mantener la estética industrial
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiProvider(
      providers: [
        // 1. Servicio de Autenticación: Origen de la verdad del usuario
        ChangeNotifierProvider(
          create: (_) => AuthService()..checkAuthStatus(), 
        ),
        // 2. Servicio de Posts: Depende del token del AuthService
        ChangeNotifierProxyProvider<AuthService, PostService>(
          create: (_) => PostService(),
          update: (_, auth, postService) {
            // Se inyecta el token cada vez que el estado de auth cambie
            return postService!..updateToken(auth.token);
          },
        ),
      ],
      child: const TecniRedApp(),
    ),
  );
}

class TecniRedApp extends StatelessWidget {
  const TecniRedApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos el estado de autenticación de forma reactiva
    final authStatus = context.watch<AuthService>().status;

    return MaterialApp(
      title: 'TecniRed',
      debugShowCheckedModeBanner: false,
      
      // Aplicamos nuestro sistema de diseño centralizado
      theme: AppTheme.lightTheme, 
      
      // Control centralizado del flujo de entrada (Guard de navegación)
      home: _buildHome(authStatus),

      // Definición de rutas nombradas para navegación interna
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/create-post': (context) => const CreatePostScreen(),
      },
    );
  }

  /// Constructor inteligente de la pantalla inicial basado en el estado
  Widget _buildHome(AuthStatus status) {
    switch (status) {
      case AuthStatus.checking:
        return const _SplashScreen();
        
      case AuthStatus.authenticated:
        return const HomeScreen();
        
      case AuthStatus.unauthenticated:
        return const LoginScreen();
    }
  }
}

/// Widget interno para la pantalla de carga (Splash) - Blindado y Constante
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.pureWhite, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentBlack),
            ),
            SizedBox(height: 32),
            Text(
              "TECNIRED",
              style: TextStyle(
                color: AppTheme.accentBlack,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Sincronizando red técnica...", 
              style: TextStyle(
                color: AppTheme.textSecondary, 
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}