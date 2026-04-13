import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'auth_state.dart';
import 'login_screen.dart';
import 'feed_screen.dart';
import 'route_guard.dart';

// El main() debe ser asíncrono para cargar la sesión antes de arrancar la UI
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Cargamos tokens del disco
  await AuthService.instance.loadSession();
  
  // 2. Inicializamos el flujo reactivo
  AuthState.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: AuthState.instance.stream,
      initialData: null, 
      builder: (context, snapshot) {
        
        // ⏳ PANTALLA DE CARGA (Splash dinámico)
        if (snapshot.data == null || snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp( // Quitamos const para evitar errores de compilación
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.indigo),
                    const SizedBox(height: 20),
                    Text("Iniciando Tecnired...", 
                      style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
          );
        }

        final bool logged = snapshot.data!;

        // 🏠 APLICACIÓN PRINCIPAL
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tecnired Enterprise',
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.light,
          ),
          // Decisión de ruta raíz basada en el Stream
          home: logged
              ? RouteGuard.protect(
                  const FeedScreen(),
                  roles: const ["admin", "technician"],
                )
              : const LoginScreen(),
        );
      },
    );
  }
}