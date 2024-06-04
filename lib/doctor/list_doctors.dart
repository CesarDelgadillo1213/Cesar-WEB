import 'package:flutter/material.dart';
import 'package:login_web/api_service.dart'; 
import 'package:login_web/doctor/doctor.dart';
import 'package:login_web/doctor/doctor_card.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late List<Doctor> _doctors = [];
  late List<Doctor> _filteredDoctors = [];
  final TextEditingController _searchController = TextEditingController();

  final ApiService _apiService = ApiService(); 

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchDoctors() async {
    try {
      List<Doctor> fetchedDoctors = await _apiService.getMedicos();

      setState(() {
        _doctors = fetchedDoctors;
        _filteredDoctors = _doctors; // Inicialmente, mostrar todos los doctores
      });
    } catch (e) {
      print('Error al obtener los médicos: $e');
    }
  }

  void _onSearchChanged() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredDoctors = _doctors.where((doctor) => doctor.nombres.toLowerCase().contains(searchTerm)).toList();
    });
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    'Doctores Agregados',
    style: TextStyle(
      color: Colors.white, // Texto en blanco
    ),
  ),
  backgroundColor: Color.fromARGB(255, 148, 27, 27), // Color de fondo rojo
),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar Doctor',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4, 
              childAspectRatio: 1.2, 
              mainAxisSpacing: 8.0, 
              crossAxisSpacing: 8.0,
              padding: EdgeInsets.all(8.0), 
              children: _filteredDoctors.map((doctor) => DoctorCard(doctor: doctor)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
