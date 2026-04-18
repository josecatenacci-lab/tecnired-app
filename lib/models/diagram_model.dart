// models/diagram_model.dart
class Diagram {
  final String id;
  final String brand;
  final String model;
  final String year;
  final String description;
  final String imageUrl;
  final String technicalNote;

  Diagram({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.description,
    required this.imageUrl,
    this.technicalNote = "",
  });
}