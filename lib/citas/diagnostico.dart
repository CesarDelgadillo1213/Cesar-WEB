import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DiagnosticoPage extends StatefulWidget {
  final int idCita;

  DiagnosticoPage({required this.idCita});

  @override
  _DiagnosticoPageState createState() => _DiagnosticoPageState();
}

class _DiagnosticoPageState extends State<DiagnosticoPage> {
  TextEditingController _diagnosticoController = TextEditingController();
  TextEditingController _recetaMedicaController = TextEditingController();
  TextEditingController _observacionesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Diagnóstico'),
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
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _diagnosticoController,
                        decoration: InputDecoration(
                          labelText: 'Diagnóstico',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null, // Allow unlimited lines
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _recetaMedicaController,
                        decoration: InputDecoration(
                          labelText: 'Receta Médica',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null, // Allow unlimited lines
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _observacionesController,
                        decoration: InputDecoration(
                          labelText: 'Observaciones',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null, // Allow unlimited lines
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _guardarDiagnostico();
                        },
                        child: Text('Agregar Diagnóstico'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.deepPurple),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
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

  void _guardarDiagnostico() {
  // Obtener los valores de los campos
  String diagnostico = _diagnosticoController.text;
  String recetaMedica = _recetaMedicaController.text;
  String observaciones = _observacionesController.text;

  // Validar que todos los campos obligatorios estén llenos
  if (diagnostico.isEmpty || recetaMedica.isEmpty || observaciones.isEmpty) {
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

  // Imprimir los valores en la consola junto con el ID de la cita
  print('ID de la cita: ${widget.idCita}');
  print('Diagnóstico: $diagnostico');
  print('Receta Médica: $recetaMedica');
  print('Observaciones: $observaciones');

  // Muestra un toast de éxito al agregar el diagnóstico
  Fluttertoast.showToast(
    msg: 'Diagnóstico agregado exitosamente.',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );

  // Limpiar los campos después de imprimir en la consola
  _diagnosticoController.clear();
  _recetaMedicaController.clear();
  _observacionesController.clear();

  // Regresar a la pantalla anterior
  Navigator.pop(context);
}

}
