// screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../services/auth_service.dart';

// Importación de las pestañas (Tabs)
import 'tabs/chat_tab.dart';
import 'tabs/cortes_tab.dart';
import 'tabs/comandos_tab.dart';
import 'tabs/herramientas_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Índice para controlar la navegación
  int _selectedIndex = 0;

  // Lista de vistas vinculadas (Mantenemos la integridad de los Widgets)
  final List<Widget> _views = const [
    ChatTab(),         // Tab 0
    CortesTab(),       // Tab 1
    ComandosTab(),     // Tab 2
    HerramientasTab(), // Tab 3
  ];

  /// Método centralizado para cerrar sesión con limpieza de estado
  void _handleLogout(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    // Ejecutamos la lógica de limpieza en el servicio
    authService.logout();
    
    // Navegación blindada: elimina todo el historial para que no puedan volver atrás
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    debugPrint("Sesión de TecniRed finalizada de forma segura.");
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos el AuthService para obtener los datos del técnico logueado
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: AppTheme.fbLightBg,
      
      // 1. EL DRAWER (Menú Lateral)
      drawer: _buildDrawer(context, authService),

      // 2. LA APP BAR (Personalizada)
      appBar: CustomAppBar(
        onSearch: (query) => debugPrint("Buscando en red TecniRed: $query"),
        onLogout: () => _handleLogout(context),
      ),

      // 3. EL CUERPO DINÁMICO con IndexedStack para preservar el estado de los tabs
      body: IndexedStack(
        index: _selectedIndex,
        children: _views,
      ),

      // 4. EL BOTTOM NAVIGATION BAR (Estilo Industrial/Limpio)
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppTheme.fbDivider, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: AppTheme.accentBlack,
          unselectedItemColor: AppTheme.textSecondary,
          backgroundColor: AppTheme.pureWhite,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car_outlined),
              activeIcon: Icon(Icons.directions_car),
              label: 'Cortes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.terminal_outlined),
              activeIcon: Icon(Icons.terminal),
              label: 'Comandos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.construction_outlined),
              activeIcon: Icon(Icons.construction),
              label: 'Herramientas',
            ),
          ],
        ),
      ),
      
      // 5. BOTÓN FLOTANTE (FAB) - Solo aparece en secciones de creación
      floatingActionButton: (_selectedIndex == 1 || _selectedIndex == 2)
          ? FloatingActionButton(
              backgroundColor: AppTheme.accentBlack,
              foregroundColor: AppTheme.pureWhite,
              elevation: 4,
              onPressed: () {
                if (_selectedIndex == 1) debugPrint("Acción: Nuevo diagrama de corte");
                if (_selectedIndex == 2) debugPrint("Acción: Nuevo comando técnico");
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  /// Estructura del Menú Lateral (Drawer) - Con datos dinámicos del AuthService
  Widget _buildDrawer(BuildContext context, AuthService auth) {
    return Drawer(
      backgroundColor: AppTheme.pureWhite,
      surfaceTintColor: Colors.transparent, 
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.accentBlack),
            margin: EdgeInsets.zero,
            currentAccountPicture: const CircleAvatar(
              backgroundColor: AppTheme.fbLightBg,
              child: Icon(Icons.engineering, color: AppTheme.accentBlack, size: 40),
            ),
            // BLINDAJE: Si el nombre no llega, ponemos un valor por defecto
            accountName: Text(
              auth.userName ?? "Técnico TecniRed", 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
            ),
            accountEmail: Text(
              auth.userId ?? "sin_correo@tecnired.com",
              style: const TextStyle(color: Colors.white70)
            ),
          ),
          
          ListTile(
            leading: const Icon(Icons.person_outline, color: AppTheme.accentBlack),
            title: const Text("Mi Perfil"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.history_outlined, color: AppTheme.accentBlack),
            title: const Text("Mis Aportes"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border, color: AppTheme.accentBlack),
            title: const Text("Diagramas Guardados"),
            onTap: () => Navigator.pop(context),
          ),
          
          const Divider(color: AppTheme.fbDivider, indent: 16, endIndent: 16),
          
          ListTile(
            leading: const Icon(Icons.settings_outlined, color: AppTheme.accentBlack),
            title: const Text("Configuración"),
            onTap: () => Navigator.pop(context),
          ),
          
          const Spacer(), 
          
          const Divider(color: AppTheme.fbDivider),
          
          ListTile(
            leading: const Icon(Icons.logout, color: AppTheme.accentRed),
            title: const Text(
              "Cerrar Sesión", 
              style: TextStyle(color: AppTheme.accentRed, fontWeight: FontWeight.bold)
            ),
            onTap: () {
              Navigator.pop(context); 
              _handleLogout(context);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}