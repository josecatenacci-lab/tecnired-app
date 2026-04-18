// models/comment_model.dart
class CommentModel {
  final String id;
  final String postId;      // ID del post al que pertenece la respuesta
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final String content;     // El texto de la respuesta técnica o social
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.content,
    required this.createdAt,
  });

  // Para recibir las respuestas desde el servidor
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      userName: json['userName'],
      userPhotoUrl: json['userPhotoUrl'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Para enviar una nueva respuesta al servidor
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}