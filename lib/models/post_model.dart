// models/post_model.dart
import 'post_type.dart';
import 'vehicle_post.dart';

class PostModel {
  final String id;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final String content;        // Texto de la publicación
  final List<String> images;   // Fotos subidas
  final PostType type;         // .libre, .corte, .diagrama, .conexion
  final DateTime createdAt;
  
  final VehiclePost? vehicleData; 

  final int likes;
  final int commentsCount;

  // --- ALIAS DE COMPATIBILIDAD (Para proteger pantallas existentes) ---
  String get usuario => userName;
  String get titulo => content; 
  DateTime get fecha => createdAt;
  PostType get tipo => type;
  String get detalles => content; 
  // -----------------------------------------------------------------------

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.content,
    this.images = const [],
    required this.type,
    required this.createdAt,
    this.vehicleData,
    this.likes = 0,
    this.commentsCount = 0,
  });

  /// factory PostModel.fromJson
  /// Mapea la respuesta del backend (Render) al objeto de Dart
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      userName: json['userName'] ?? 'Técnico TecniRed',
      userPhotoUrl: json['userPhotoUrl'],
      content: json['content'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      // Mapeo seguro del Enum
      type: PostType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PostType.libre,
      ),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      vehicleData: json['vehicleData'] != null 
          ? VehiclePost.fromJson(json['vehicleData']) 
          : null,
      likes: json['likes'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
    );
  }

  /// Map<String, dynamic> toJson
  /// CORRECCIÓN CRÍTICA: Permite que PostService envíe datos a la API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'content': content,
      'images': images,
      'type': type.name, // Enviamos el String del enum ("corte", "diagrama", etc.)
      'createdAt': createdAt.toIso8601String(),
      'vehicleData': vehicleData?.toJson(), // Recursividad si el vehículo tiene su toJson
      'likes': likes,
      'commentsCount': commentsCount,
    };
  }
}