// services/post_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart'; // Para debugPrint
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../models/post_type.dart';

class PostService extends ChangeNotifier {
  // Configuración de la API en Render
  final String _baseUrl = 'https://tu-api-en-render.com/api';
  
  List<PostModel> _posts = [];
  bool _isLoading = false;
  String? _token; 

  // Getters
  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  /// Inyecta el token desde el AuthService (usualmente vía ProxyProvider en main.dart)
  void updateToken(String? newToken) {
    if (_token != newToken) {
      _token = newToken;
      // Si el token llega y no hay posts, intentamos cargarlos automáticamente
      if (_token != null && _posts.isEmpty) {
        fetchPosts();
      }
    }
  }

  /// OBTENER POSTS (GET)
  Future<void> fetchPosts() async {
    // Si no hay token o ya está cargando, evitamos peticiones innecesarias
    if (_token == null || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse('$_baseUrl/posts');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': _token!, 
        },
      ).timeout(const Duration(seconds: 15)); // Timeout para redes lentas

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _posts = data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        debugPrint("TecniRed Error: Código ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error en fetchPosts: $e");
      // Si falla la red, podemos cargar mocks para que la UI no se vea rota
      if (_posts.isEmpty) loadMockData();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// CREAR APORTE (POST)
  Future<bool> createPost(PostModel newPost) async {
    if (_token == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse('$_baseUrl/posts');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': _token!,
        },
        body: jsonEncode(newPost.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final createdPost = PostModel.fromJson(jsonDecode(response.body));
        // Insertamos al inicio para que el técnico vea su aporte de inmediato
        _posts.insert(0, createdPost); 
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error al crear post: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// MÉTODOS DE APOYO (MOCK)
  /// Evita que la pantalla se vea vacía durante el desarrollo
  void loadMockData() {
    _posts = [
      PostModel(
        id: '1',
        userId: 'admin',
        userName: 'Soporte TecniRed',
        content: 'Bienvenido a la red técnica. Si la API no responde, verás este mensaje de prueba.',
        type: PostType.libre,
        createdAt: DateTime.now(),
        images: const [],
      ),
    ];
    notifyListeners();
  }
}