import 'package:flutter/material.dart';
import 'package:login_web/api_service.dart';
import 'package:login_web/historial/Consulta.dart';
import 'package:login_web/historial/consulta_card.dart';


class ConsultasPage extends StatefulWidget {
  final int idPaciente;

  ConsultasPage({required this.idPaciente});
  @override
  _ConsultasPageState createState() => _ConsultasPageState();
}

class _ConsultasPageState extends State<ConsultasPage> {
  List<Consulta> consultas = []; // Inicializamos consultas como una lista vacía

  @override
  void initState() {
    super.initState();
    loadConsultas();
  }

  Future<void> loadConsultas() async {
    try {
      // Aquí cargamos las consultas utilizando el método getConsultasById del ApiService
      List<Consulta> consultasLoaded =
          await ApiService().getConsultasById(widget.idPaciente);
      setState(() {
        consultas =
            consultasLoaded; // Actualizamos consultas con los datos cargados
      });
    } catch (e) {
      // Manejar errores al cargar las consultas
      print('Error al cargar consultas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Consultas'),
      ),
      body: consultas.isNotEmpty
          ? ListView.builder(
              itemCount: consultas.length,
              itemBuilder: (context, index) {
                return ConsultaCard(consulta: consultas[index]);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
