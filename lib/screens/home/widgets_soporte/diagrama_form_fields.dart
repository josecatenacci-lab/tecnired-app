// screens/home/Widgets_soporte/diagrama_form_fields.dart
import 'package:flutter/material.dart';

class DiagramaFormFields extends StatelessWidget {
  final TextEditingController controller;

  const DiagramaFormFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Información del Diagrama",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Ej: Pin 5 (Rojo) = Positivo constante, Pin 8 (Negro) = Tierra chasis...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            // Cambio aplicado: .withValues(alpha: ...) para cumplir con Flutter 3.27+
            fillColor: Colors.blue.withValues(alpha: 0.05),
          ),
          validator: (v) => v!.isEmpty ? "Ingresa la descripción del diagrama" : null,
        ),
        const SizedBox(height: 10),
        const Text(
          "Registra la configuración de pines o conexiones eléctricas clave.",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}