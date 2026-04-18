// models/models.dart
import 'package:flutter/material.dart';

enum PostType {
  corte,
  diagrama,
  conexion,
}

extension PostTypeExtension on PostType {
  // El nombre que se muestra en el AppBar y botones
  String get displayName {
    switch (this) {
      case PostType.corte:
        return 'Corte de Motor';
      case PostType.diagrama:
        return 'Diagrama Eléctrico';
      case PostType.conexion:
        return 'Punto de Conexión';
    }
  }

  // El color temático para la pantalla y el botón
  Color get color {
    switch (this) {
      case PostType.corte:
        return Colors.redAccent;
      case PostType.diagrama:
        return Colors.blueAccent;
      case PostType.conexion:
        return Colors.green;
    }
  }

  // La descripción que aparece debajo del botón de la cámara
  String get description {
    switch (this) {
      case PostType.corte:
        return 'Captura el cable de bloqueo';
      case PostType.diagrama:
        return 'Captura el plano del manual';
      case PostType.conexion:
        return 'Captura donde conectaste el GPS';
    }
  }
}

class Post {
  final String id;
  final String marca;
  final String modelo;
  final String anio;
  final String descripcion;
  final PostType type;
  final String? imageUrl;

  Post({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.descripcion,
    required this.type,
    this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] ?? '',
      marca: json['marca'] ?? '',
      modelo: json['modelo'] ?? '',
      anio: json['anio'] ?? '',
      descripcion: json['descripcion'] ?? '',
      type: PostType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PostType.corte,
      ),
      imageUrl: json['imageUrl'],
    );
  }
}