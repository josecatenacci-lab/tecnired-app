// screens/home/Widgets_soporte/conexion_form_fields.dart
import 'package:flutter/material.dart';

class ConexionFormFields extends StatelessWidget {
  final TextEditingController controller;

  const ConexionFormFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ubicación de la Conexión",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Ej: Detrás del cuadro de instrumentos, asegurado con precintos a la base metálica...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            // Cambio de withOpacity a withValues para evitar el warning
            fillColor: Colors.green.withValues(alpha: 0.05),
          ),
          validator: (v) => v!.isEmpty ? "Indica la ubicación física" : null,
        ),
        const SizedBox(height: 10),
        const Text(
          "Describe dónde ocultaste el GPS y por dónde pasan los cables principales.",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}