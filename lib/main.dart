import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'auth_state.dart';
import 'login_screen.dart';
import 'feed_screen.dart';
import 'route_guard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.instance.loadSession();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: AuthState.instance.stream,
      initialData: AuthService.instance.isLoggedIn,
      builder: (context, snapshot) {
        final logged = snapshot.data ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
          home: logged
              ? RouteGuard.protect(const FeedScreen(), roles: ["admin", "technician"])
              : const LoginScreen(),
        );
      },
    );
  }
}