import 'package:flutter/material.dart';
import 'package:login_web/api_service.dart';
import 'package:login_web/citas/cita.dart';
import 'package:login_web/citas/detalles_cita.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerCitas extends StatefulWidget {
  @override
  _VerCitasState createState() => _VerCitasState();
}

class _VerCitasState extends State<VerCitas> {
  late List<Cita> citas = [];
  late List<Cita> citasFiltradas = []; // Lista para almacenar citas filtradas
  final ApiService apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCitas();
  }

  Future<void> _fetchCitas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int retrievedUserId = prefs.getInt('userId') ?? -1;
      bool isAdmin = prefs.getBool('isAdmin') ?? false;

      List<Cita> fetchedCitas;
      if (isAdmin) {
        fetchedCitas = await apiService.getCitas();
      } else {
        fetchedCitas = await apiService.getCitasByDoctor(retrievedUserId);
      }

      setState(() {
        citas = fetchedCitas;
        // Al principio, mostrar todas las citas sin filtrar
        citasFiltradas = List.from(citas);
      });
    } catch (e) {
      print('Error al obtener las citas: $e');
    }
  }

  // Método para filtrar las citas según el ID ingresado por el usuario
  void _filterCitas(String searchText) {
    setState(() {
      citasFiltradas = citas.where((cita) {
        // Filtrar por ID de cita
        bool idMatches = cita.idCita.toString().contains(searchText);
        // Filtrar por nombre del paciente (ignorando mayúsculas/minúsculas)
        bool pacienteMatches = cita.nombrePaciente
            .toLowerCase()
            .contains(searchText.toLowerCase());
        // Filtrar por nombre del médico (ignorando mayúsculas/minúsculas)
        bool medicoMatches = cita.nombreMedico
                ?.toLowerCase()
                .contains(searchText.toLowerCase()) ??
            false;
        // Retornar verdadero si al menos una de las condiciones coincide
        return idMatches || pacienteMatches || medicoMatches;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citas Confirmadas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged:
                  _filterCitas, // Llamar al método de filtrado cuando cambie el texto
              decoration: InputDecoration(
                labelText: 'Buscar cita por ID o Paciente',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: citasFiltradas.isEmpty
                ? Center(child: Text('No hay citas confirmadas'))
                : ListView.builder(
                    itemCount: citasFiltradas.length,
                    itemBuilder: (context, index) =>
                        CitaCard(cita: citasFiltradas[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class CitaCard extends StatelessWidget {
  final Cita cita;

  const CitaCard({
    Key? key,
    required this.cita,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService(); // Instancia de ApiService

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetallesCita(cita: cita, apiService: apiService),
          ),
        );
      },
      child: Container(
        width: 300, // Ancho fijo de 300 unidades
        height: 200, // Altura fija de 200 unidades
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centrar verticalmente
              children: [
                Text(
                  'ID Cita: ${cita.idCita}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Paciente: ${cita.nombrePaciente}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blue, size: 14),
                    SizedBox(width: 7),
                    Text(
                      'Fecha: ${cita.fecha}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.blue, size: 14),
                    SizedBox(width: 7),
                    Text(
                      'Hora: ${cita.hora}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                if (cita.nombreMedico != null && cita.nombreMedico!.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(height: 7),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.blue, size: 15),
                          SizedBox(width: 7),
                          Text(
                            'Médico: ${cita.nombreMedico}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
