// utils/constants.dart
class AppConstants {
  // 1. Configuración de API (Aquí pondrás tu URL de Render)
  static const String baseUrl = 'https://tecnired-backend.onrender.com/api';
  
  // 2. Títulos y Textos Globales
  static const String appName = 'TECNIRED';
  static const String networkName = 'Red Técnica de Monitoreo';
  
  // 3. Endpoints específicos
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String postsEndpoint = '/posts';
  static const String searchEndpoint = '/posts/search';

  // 4. Timeouts (Para evitar que la app se quede colgada si el servidor de Render tarda en despertar)
  static const int connectionTimeout = 15000; // 15 segundos
  static const int receiveTimeout = 15000;

  // 5. Categorías de Posts (Coinciden con los nombres en el Backend)
  static const Map<String, String> postCategories = {
    'libre': 'Publicación Libre',
    'corte': 'Corte de Motor',
    'diagrama': 'Diagrama Eléctrico',
    'conexion': 'Punto de Conexión',
  };
}