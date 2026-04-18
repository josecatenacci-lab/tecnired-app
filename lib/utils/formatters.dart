// utils/formatters.dart
import 'package:intl/intl.dart';

class AppFormatters {
  // 1. Formatear fecha relativa (Hace 5 min, Ayer, etc.)
  static String timeAgo(DateTime date) {
    final duration = DateTime.now().difference(date);

    if (duration.inDays > 7) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else if (duration.inDays >= 1) {
      return 'Hace ${duration.inDays} ${duration.inDays == 1 ? 'día' : 'días'}';
    } else if (duration.inHours >= 1) {
      return 'Hace ${duration.inHours} ${duration.inHours == 1 ? 'hora' : 'horas'}';
    } else if (duration.inMinutes >= 1) {
      return 'Hace ${duration.inMinutes} min';
    } else {
      return 'Ahora mismo';
    }
  }

  // 2. Capitalizar nombres (Ej: toyota -> Toyota)
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  // 3. Formatear para búsqueda (Quitar espacios y minúsculas)
  static String formatForSearch(String text) {
    return text.trim().toLowerCase();
  }
}