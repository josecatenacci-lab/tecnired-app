// screens/home/create_post_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../models/post_model.dart';
import '../../models/post_type.dart';
import '../../models/vehicle_post.dart';
import '../../services/auth_service.dart';
import '../../services/post_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Estado local del formulario
  String _content = '';
  PostType _selectedType = PostType.libre;
  String _brand = '';
  String _model = '';
  String _year = ''; 

  @override
  Widget build(BuildContext context) {
    // Usamos listen: false para evitar reconstrucciones al escribir
    final authService = Provider.of<AuthService>(context, listen: false);
    // Para el estado de carga sí necesitamos observar el servicio
    final postService = context.watch<PostService>();

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        title: const Text(
          "CREAR APORTE TÉCNICO",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.darkSurface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Selector de Tipo de Aporte
              _sectionTitle("TIPO DE TRABAJO"),
              const SizedBox(height: 10),
              
              // CORRECCIÓN: Se usa initialValue en lugar de value para evitar deprecación en v3.33+
              DropdownButtonFormField<PostType>(
                dropdownColor: AppTheme.darkSurface,
                initialValue: _selectedType, 
                items: PostType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(
                      type.displayName, 
                      style: const TextStyle(color: AppTheme.textPrimary)
                    ),
                  );
                }).toList(),
                onChanged: postService.isLoading ? null : (val) {
                  if (val != null) setState(() => _selectedType = val);
                },
                decoration: _inputDecoration("Selecciona categoría"),
              ),

              const SizedBox(height: 25),

              // 2. Sección de Vehículo
              _sectionTitle("DATOS DEL VEHÍCULO"),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: AppTheme.textPrimary),
                decoration: _inputDecoration("Marca (Ej: Toyota)"),
                textCapitalization: TextCapitalization.words,
                onChanged: (val) => _brand = val,
                validator: (val) => (val == null || val.isEmpty) ? "La marca es necesaria" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: AppTheme.textPrimary),
                decoration: _inputDecoration("Modelo o Chasis (Ej: Hilux)"),
                textCapitalization: TextCapitalization.characters,
                onChanged: (val) => _model = val,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: AppTheme.textPrimary),
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Año (Opcional)"),
                onChanged: (val) => _year = val,
              ),

              const SizedBox(height: 25),

              // 3. Contenido Técnico
              _sectionTitle("DETALLE TÉCNICO / INSTRUCCIONES"),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 6,
                style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15),
                decoration: _inputDecoration("Describe cables, voltajes o ubicación de módulos..."),
                validator: (val) => (val == null || val.length < 10) 
                    ? "La descripción técnica es muy corta" 
                    : null,
                onChanged: (val) => _content = val,
              ),

              const SizedBox(height: 40),

              // 4. Botón de Publicación
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentBlue,
                    // CORRECCIÓN: Uso de withValues para evitar avisos de deprecación
                    disabledBackgroundColor: AppTheme.accentBlue.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: postService.isLoading 
                    ? null 
                    : () => _submitPost(authService, postService),
                  child: postService.isLoading
                    ? const SizedBox(
                        height: 20, 
                        width: 20, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                    : const Text(
                        "PUBLICAR APORTE", 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                      ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _submitPost(AuthService auth, PostService service) async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final newPost = PostModel(
      id: '', 
      userId: auth.userId ?? '',
      userName: auth.userName ?? 'Técnico TecniRed', 
      content: _content,
      type: _selectedType,
      createdAt: DateTime.now(),
      images: const [], // CORRECCIÓN: Se agrega const
      vehicleData: VehiclePost(
        brand: _brand,
        model: _model,
        year: _year,
      ),
    );

    final success = await service.createPost(newPost);

    if (success && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Aporte técnico guardado con éxito"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Widget _sectionTitle(String title) {
    return Text(
      title, 
      style: const TextStyle(
        color: AppTheme.accentBlue, 
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        fontSize: 11
      )
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
      filled: true,
      fillColor: AppTheme.darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), 
        borderSide: const BorderSide(color: AppTheme.dividerColor)
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), 
        borderSide: const BorderSide(color: AppTheme.dividerColor)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), 
        borderSide: const BorderSide(color: AppTheme.accentBlue, width: 1.5)
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), 
        borderSide: const BorderSide(color: Colors.redAccent)
      ),
    );
  }
}