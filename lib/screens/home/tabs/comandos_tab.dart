// screens/home/tabs/comandos_tab.dart
import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class ComandosTab extends StatefulWidget {
  const ComandosTab({super.key});

  @override
  State<ComandosTab> createState() => _ComandosTabState();
}

class _ComandosTabState extends State<ComandosTab> {
  String selectedGps = "Coban (303, 311)";

  final List<String> gpsBrands = [
    "Coban (303, 311)",
    "Concox (GT06)",
    "Suntech",
    "Teltonika",
    "Queclink"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Seleccionar Equipo GPS",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          
          // Selector de Marca
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.pureWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.fbDivider),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedGps,
                isExpanded: true,
                items: gpsBrands.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() => selectedGps = newValue!);
                },
              ),
            ),
          ),

          const SizedBox(height: 25),
          const Text(
            "Comandos Rápidos (SMS)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),

          // Grilla de Botones de Comandos
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              _buildCommandButton(
                "Ubicación", 
                Icons.location_on, 
                Colors.blue, 
                "fix030s001nadmin123456"
              ),
              _buildCommandButton(
                "Apagar Motor", 
                Icons.block, 
                AppTheme.accentRed, 
                "stop123456"
              ),
              _buildCommandButton(
                "Reanudar Motor", 
                Icons.play_arrow, 
                Colors.green, 
                "resume123456"
              ),
              _buildCommandButton(
                "Status", 
                Icons.info_outline, 
                Colors.orange, 
                "check123456"
              ),
              _buildCommandButton(
                "Reiniciar GPS", 
                Icons.refresh, 
                Colors.purple, 
                "reset123456"
              ),
              _buildCommandButton(
                "Config. APN", 
                Icons.settings_input_antenna, 
                Colors.grey, 
                "apn123456 internet.com"
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommandButton(String title, IconData icon, Color color, String comando) {
    return InkWell(
      onTap: () => _showConfirmCommand(title, comando),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _showConfirmCommand(String name, String cmd) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enviar $name"),
        content: Text("Se enviará el comando: \n\n'$cmd'\n\n¿Deseas continuar?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentBlack),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Comando '$name' copiado al portapapeles / Enviando...")),
              );
            }, 
            child: const Text("Enviar SMS", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}