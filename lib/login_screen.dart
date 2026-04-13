// ... importaciones
import 'package:flutter/material.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;
  bool _obscurePass = true; // 🔥 Mejora: Opción para ver contraseña

  Future<void> _login() async {
    final emailTxt = _email.text.trim();
    final passTxt = _pass.text.trim();

    if (emailTxt.isEmpty || passTxt.isEmpty) {
      _showMsg("Por favor, completa todos los campos", isError: true);
      return;
    }

    setState(() => _loading = true);

    try {
      final ok = await AuthService.instance.login(emailTxt, passTxt);
      
      if (!ok && mounted) {
        _showMsg("Credenciales incorrectas o error de servidor", isError: true);
      }
      // 📍 Nota: Si 'ok' es true, el StreamBuilder del main cambiará la pantalla solo.
    } catch (e) {
      if (mounted) _showMsg("Error de conexión: Verifica tu internet", isError: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showMsg(String text, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: isError ? Colors.redAccent : Colors.indigo,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center( // 🔥 Mejorado: Centrado real
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.security_rounded, size: 100, color: Colors.indigo),
                const SizedBox(height: 10),
                const Text(
                  "TECNIRED GPS",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    letterSpacing: 1.5,
                  ),
                ),
                const Text("SISTEMA DE MONITOREO", 
                  style: TextStyle(color: Colors.blueGrey, letterSpacing: 2, fontSize: 10)),
                const SizedBox(height: 50),

                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Correo Electrónico",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _pass,
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton( // 🔥 Toggle para ver password
                      icon: Icon(_obscurePass ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscurePass = !_obscurePass),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                _loading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        height: 55, // Botón ligeramente más alto
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            "INGRESAR AL SISTEMA",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}