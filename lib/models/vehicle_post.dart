// models/vehicle_post.dart

class VehiclePost {
  final String brand;
  final String model;
  final String? year;      // Lo hacemos opcional con '?'
  final String? location;  // Por si quieres añadir ubicación después

  VehiclePost({
    required this.brand,
    required this.model,
    this.year,             // Quitamos el 'required' de aquí
    this.location,
  });

  // Mapeo para enviar a tu API en Render
  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'model': model,
      'year': year ?? '', // Si es null, enviamos string vacío
      'location': location ?? '',
    };
  }

  // Mapeo para recibir de la base de datos
  factory VehiclePost.fromJson(Map<String, dynamic> json) {
    return VehiclePost(
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      year: json['year']?.toString(), // Blindaje por si viene como int o string
      location: json['location'],
    );
  }
}