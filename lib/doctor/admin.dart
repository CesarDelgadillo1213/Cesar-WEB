import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_web/api_service.dart';

class PostMedicoPage extends StatefulWidget {
  @override
  _PostMedicoPageState createState() => _PostMedicoPageState();
}

class _PostMedicoPageState extends State<PostMedicoPage> {
  List<String> _especialidades = [
    'Alergología', 'Anestesiología', 'Cardiología', 'Cirugía', 'Dermatología',
    'Endocrinología', 'Gastroenterología', 'Geriatría', 'Ginecología', 'Hematología',
    'Infectología', 'Medicina de emergencia', 'Medicina deportiva', 'Medicina familiar',
    'Medicina interna', 'Nefrología', 'Neumología', 'Neurología', 'Obstetricia',
    'Oncología', 'Oftalmología', 'Ortopedia', 'Otorrinolaringología', 'Pediatría',
    'Psiquiatría', 'Radiología', 'Reumatología', 'Traumatología', 'Urología'
  ];

  List<String> _selectedEspecialidades = [];
  TextEditingController _nombresController = TextEditingController();
  TextEditingController _apellidosController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Médico'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      controller: _nombresController,
                      decoration: InputDecoration(
                        labelText: 'Nombres',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _apellidosController,
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Especialidades:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildAutocompleteTextField(),
                    SizedBox(height: 20),
                    _buildSelectedEspecialidadesChips(),
                    SizedBox(height: 20),
                    TextField(
                      controller: _descripcionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre de usuario',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
  onPressed: () {
    _guardarMedico();
  },
  child: Text('Agregar Médico'),
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
),

                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAutocompleteTextField() {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return _especialidades.where((String option) {
          return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
        });
      },
      onSelected: (String selectedOption) {
        setState(() {
          if (!_selectedEspecialidades.contains(selectedOption)) {
            _selectedEspecialidades.add(selectedOption);
          }
        });
      },
      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: (String value) {
            _updateAutocompleteOptions(value);
          },
          decoration: InputDecoration(
            hintText: 'Ingrese una especialidad',
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                textEditingController.clear();
                _updateAutocompleteOptions('');
              },
            ),
          ),
          onSubmitted: (String value) {
            if (value.isNotEmpty && !_selectedEspecialidades.contains(value)) {
              setState(() {
                _selectedEspecialidades.add(value);
                textEditingController.clear();
              });
            }
          },
        );
      },
    );
  }

  Widget _buildSelectedEspecialidadesChips() {
    return Wrap(
      spacing: 8.0,
      children: _selectedEspecialidades.map((especialidad) {
        return Chip(
          label: Text(especialidad),
          deleteIcon: Icon(Icons.cancel),
          onDeleted: () {
            setState(() {
              _selectedEspecialidades.remove(especialidad);
            });
          },
        );
      }).toList(),
    );
  }

  void _updateAutocompleteOptions(String value) {
    setState(() {});
  }
  void _guardarMedico() {
  // Obtener los valores de los campos
  String nombres = _nombresController.text;
  String apellidos = _apellidosController.text;
  String descripcion = _descripcionController.text;
  String username = _usernameController.text;
  String password = _passwordController.text;

  // Validar que todos los campos obligatorios estén llenos
  if (nombres.isEmpty || apellidos.isEmpty || _selectedEspecialidades.isEmpty || descripcion.isEmpty || username.isEmpty || password.isEmpty) {
    Fluttertoast.showToast(
      msg: 'Por favor, llene todos los campos.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return;
  }

  // Llama al método para agregar el médico a través de la API
  ApiService().createMedico(
    nombres,
    apellidos,
    _selectedEspecialidades,
    descripcion,
    username,
    password,
  ).then((_) {
    // Muestra un mensaje de éxito
    Fluttertoast.showToast(
      msg: 'Médico agregado exitosamente.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Limpia los campos y actualiza la lista de especialidades seleccionadas
    _nombresController.clear();
    _apellidosController.clear();
    _descripcionController.clear();
    _usernameController.clear();
    _passwordController.clear();
    setState(() {
      _selectedEspecialidades.clear();
    });

    // Vuelve a la pantalla de inicio
    Navigator.pop(context);
  }).catchError((error) {
    // Maneja errores de la API
    Fluttertoast.showToast(
      msg: 'Error al agregar médico: $error',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  });
}
}
