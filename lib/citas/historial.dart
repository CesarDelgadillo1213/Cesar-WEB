import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistorialMedicoPacienteScreen extends StatefulWidget {
  final int idPaciente;

  HistorialMedicoPacienteScreen({required this.idPaciente});

  @override
  _HistorialMedicoPacienteScreenState createState() =>
      _HistorialMedicoPacienteScreenState();
}

class _HistorialMedicoPacienteScreenState
    extends State<HistorialMedicoPacienteScreen> {
  late Future<Map<String, dynamic>> _historialFuture;

  @override
  void initState() {
    super.initState();
    _historialFuture = _fetchHistorialMedico(widget.idPaciente);
  }

  Future<Map<String, dynamic>> _fetchHistorialMedico(int idPaciente) async {
    final response = await http.get(
        Uri.parse('http://localhost:3000/getHistorialMedicoById?id=$idPaciente'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Si no se puede cargar el historial médico, devolvemos un mapa vacío
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial Médico'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _historialFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Si hay un error, mostramos el mensaje de error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final historial = snapshot.data!;
            if (historial.isEmpty) {
              // Si el historial está vacío, mostramos un mensaje indicando que no hay historial médico
              return Center(child: Text('No hay historial médico para este paciente aún.'));
            } else {
              // Si hay historial médico, mostramos los detalles
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Diagnóstico: ${historial['diagnostico']}'),
                    Text('Receta Médica: ${historial['receta_medica']}'),
                    Text('Observaciones: ${historial['observaciones']}'),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
