// screens/login/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/validators.dart';
import '../../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _isPasswordVisible = false; // Estado para el ojo de la contraseña

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final authService = Provider.of<AuthService>(context, listen: false);
      
      final success = await authService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      setState(() => _isLoading = false);
      
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credenciales incorrectas o servidor no disponible'),
            backgroundColor: AppTheme.accentRed,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite, // Fondo limpio profesional
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo con estética técnica
                 Image.asset(
                  'assets/images/app_logo.png',
                    height: 100, // Un poco más compacto para el Login
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    "TECNIRED",
                    style: TextStyle(
                      color: AppTheme.accentBlack,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Conecta con otros Instaladores",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.textSecondary, 
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 50),

                  // CAMPO: CORREO ELECTRÓNICO
                  _buildTextField(
                    controller: _emailController,
                    label: "Correo Electrónico",
                    hint: "ejemplo@gps.cl",
                    icon: Icons.alternate_email,
                    validator: AppValidators.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // CAMPO: CONTRASEÑA (CON OJO)
                  _buildTextField(
                    controller: _passwordController,
                    label: "Contraseña",
                    hint: "Mínimo 6 caracteres",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    obscureText: !_isPasswordVisible,
                    validator: AppValidators.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible 
                          ? Icons.visibility_off_outlined 
                          : Icons.visibility_outlined,
                        color: AppTheme.textSecondary,
                        size: 22,
                      ),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // BOTÓN DE ENTRADA
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentBlack,
                        foregroundColor: AppTheme.pureWhite,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(color: AppTheme.pureWhite, strokeWidth: 3),
                            )
                          : const Text(
                              "INICIAR SESIÓN",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                            ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // REGISTRO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿Eres nuevo?", style: TextStyle(color: AppTheme.textSecondary)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: const Text(
                          "Crea tu cuenta aquí",
                          style: TextStyle(color: AppTheme.accentBlack, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Constructor de campos de texto personalizado y blindado
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppTheme.accentBlack, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.accentBlack, size: 22),
        suffixIcon: suffixIcon,
        labelStyle: const TextStyle(color: AppTheme.textSecondary),
        hintStyle: const TextStyle(color: AppTheme.fbDivider, fontSize: 14),
        filled: true,
        fillColor: AppTheme.fbLightBg,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.fbDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.accentBlack, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.accentRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.accentRed, width: 1.5),
        ),
      ),
      validator: validator,
    );
  }
}