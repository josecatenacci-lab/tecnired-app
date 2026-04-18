// screens/shop/shop_screen.dart
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Tienda Tecnired", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _buildProductItem("Scanner Automotriz", "250.00 USD", Icons.settings_remote),
        _buildProductItem("Suscripción VIP Anual", "99.00 USD", Icons.workspace_premium),
        _buildProductItem("Kit de Desarmado", "45.00 USD", Icons.build),
      ],
    );
  }

  Widget _buildProductItem(String nombre, String precio, IconData icono) {
    return Card(
      child: ListTile(
        leading: Icon(icono, color: const Color(0xFF42B72A), size: 30),
        title: Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(precio),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(minimumSize: const Size(80, 36)),
          child: const Text("Comprar"),
        ),
      ),
    );
  }
}