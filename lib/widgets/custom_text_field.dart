// widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;
  final bool isPassword;
  final bool enabled; // AGREGADO: Para controlar el estado durante el login/registro
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
    this.isPassword = false,
    this.enabled = true, // Por defecto está activo
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            // Si está desactivado, bajamos un poco la opacidad del label
            color: enabled ? AppTheme.textSecondary : AppTheme.textSecondary.withValues(alpha: 0.5),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          enabled: enabled, // CONECTADO: Ahora el motor de Flutter sabe si debe reaccionar
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: enabled ? AppTheme.textPrimary : AppTheme.textPrimary.withValues(alpha: 0.5),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppTheme.textSecondary.withValues(alpha: 0.4), 
              fontSize: 14
            ),
            prefixIcon: icon != null 
                ? Icon(icon, color: enabled ? AppTheme.accentBlue : AppTheme.accentBlue.withValues(alpha: 0.3), size: 20) 
                : null,
            filled: true,
            fillColor: enabled ? AppTheme.darkSurface : AppTheme.darkSurface.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            
            // Bordes blindados
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.dividerColor),
            ),
            disabledBorder: OutlineInputBorder( // AGREGADO: Estado visual desactivado
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppTheme.dividerColor.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.accentBlue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}