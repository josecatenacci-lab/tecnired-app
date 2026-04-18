// screens/home/tabs/chat_tab.dart
import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 80, color: AppTheme.fbDivider),
          SizedBox(height: 16),
          Text("Chat Global TecniRed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text("Conectando técnicos en tiempo real", style: TextStyle(color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}