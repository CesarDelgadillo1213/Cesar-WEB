// consulta_card.dart
import 'package:flutter/material.dart';
import 'package:login_web/historial/Consulta.dart';

class ConsultaCard extends StatelessWidget {
  final Consulta consulta;

  ConsultaCard({required this.consulta});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha: ${consulta.fecha}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Diagnóstico: ${consulta.diagnostico}'),
            SizedBox(height: 8.0),
            Text('Receta Médica: ${consulta.recetaMedica}'),
            SizedBox(height: 8.0),
            Text('Observaciones: ${consulta.observaciones}'),
          ],
        ),
      ),
    );
  }
}