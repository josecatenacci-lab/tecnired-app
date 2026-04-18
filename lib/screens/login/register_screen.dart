// screens/login/register_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/validators.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    // DISPARADOR DE BORDES: validate() activa los errorBorder
    if (!_formKey.currentState!.validate()) return;

    final authService = Provider.of<AuthService>(context, listen: false);

    final success = await authService.register(
      _emailController.text.trim(),
      _passwordController.text, 
      _nameController.text.trim(),
    );

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Registro exitoso! Ya puedes ingresar.'),
            backgroundColor: AppTheme.accentBlack,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: El correo ya existe o falla de conexión.'),
            backgroundColor: AppTheme.accentRed,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthService>().status;
    final bool isLoading = authStatus == AuthStatus.checking;

    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.accentBlack, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Únete a TecniRed",
                    style: TextStyle(
                      color: AppTheme.accentBlack,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Crea tu perfil gratis para acceder.",
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 15),
                  ),
                  const SizedBox(height: 40),

                  _buildRegisterField(
                    controller: _nameController,
                    label: "Nombre Completo",
                    hint: "Juan Pérez",
                    icon: Icons.person_outline,
                    enabled: !isLoading,
                    validator: (v) => AppValidators.validateRequired(v, "Nombre"),
                  ),
                  const SizedBox(height: 20),

                  _buildRegisterField(
                    controller: _emailController,
                    label: "Correo Electrónico",
                    hint: "tecnico@gps.cl",
                    icon: Icons.alternate_email,
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.validateEmail,
                  ),
                  const SizedBox(height: 20),

                  _buildRegisterField(
                    controller: _passwordController,
                    label: "Contraseña",
                    hint: "Mínimo 6 caracteres",
                    icon: Icons.lock_outline,
                    enabled: !isLoading,
                    isPassword: true,
                    obscureText: !_isPasswordVisible,
                    validator: AppValidators.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentBlack,
                        foregroundColor: AppTheme.pureWhite,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(color: AppTheme.pureWhite, strokeWidth: 3),
                            )
                          : const Text("REGISTRARSE", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// HELPER CORREGIDO CON BORDES DE ERROR
  Widget _buildRegisterField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool enabled = true,
    bool isPassword = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppTheme.accentBlack, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.accentBlack, size: 22),
        suffixIcon: suffixIcon,
        labelStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        filled: true,
        fillColor: AppTheme.fbLightBg,
        
        // Bordes normales
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.fbDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.accentBlack, width: 1.5),
        ),

        // BLINDAJE: BORDES DE ERROR
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
      ),
      validator: validator,
    );
  }
}