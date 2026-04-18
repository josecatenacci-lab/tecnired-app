// services/image_service.dart
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  // 1. Capturar desde la cámara (Para el taller)
  Future<File?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70, // Compresión balanceada: nitidez vs peso
      maxWidth: 1920,   // Full HD es suficiente para diagramas
    );

    if (photo != null) {
      return File(photo.path);
    }
    return null;
  }

  // 2. Seleccionar desde la galería (Para manuales guardados)
  Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // 3. Capturar múltiples imágenes (Para posts complejos)
  Future<List<File>> pickMultiImages() async {
    final List<XFile> images = await _picker.pickMultiImage(
      imageQuality: 70,
    );
    
    return images.map((xFile) => File(xFile.path)).toList();
  }
}