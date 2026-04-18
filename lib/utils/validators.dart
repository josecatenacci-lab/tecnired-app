// utils/validators.dart
class AppValidators {
  // 1. Validar Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo es obligatorio';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Introduce un correo electrónico válido';
    }
    return null;
  }

  // 2. Validar Contraseña (Mínimo 6 caracteres para seguridad básica)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  // 3. Validar Campos de Texto Generales (Marca, Modelo, Contenido)
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'El campo $fieldName es obligatorio';
    }
    return null;
  }

  // 4. Validar Año del Vehículo (Solo números y rango lógico)
  static String? validateYear(String? value) {
    if (value == null || value.isEmpty) return 'Año obligatorio';
    final year = int.tryParse(value);
    if (year == null || year < 1980 || year > 2027) {
      return 'Año no válido';
    }
    return null;
  }
}