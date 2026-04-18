// screens/home/Widgets_soporte/corte_form_fields.dart
import 'package:flutter/material.dart';

class CorteFormFields extends StatelessWidget {
  final TextEditingController controller;

  const CorteFormFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Detalles del Corte de Motor",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Ej: Cable color verde grueso en el ramal izquierdo del tablero...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            // Cambio aplicado: .withValues en lugar de .withOpacity
            fillColor: Colors.red.withValues(alpha: 0.05),
          ),
          validator: (v) => v!.isEmpty ? "Describe el punto de corte" : null,
        ),
        const SizedBox(height: 10),
        const Text(
          "Indica color de cable, ubicación y tipo de señal (IGN, Start, etc.)",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}