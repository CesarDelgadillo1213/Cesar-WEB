import 'package:flutter/material.dart';
import 'package:login_web/api_service.dart'; 
import 'package:login_web/doctor/doctor.dart';
import 'package:login_web/doctor/doctor_card.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late List<Doctor> doctors = [];

  final ApiService apiService = ApiService(); 

  @override
  void initState() {
    super.initState();
   
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      
      List<Doctor> fetchedDoctors = await apiService.getMedicos();

      setState(() {
        doctors = fetchedDoctors;
      });
    } catch (e) {
      
      print('Error al obtener los médicos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctores Registrados'),
      ),
      body: GridView.count(
        crossAxisCount: 4, 
        childAspectRatio: 1.2, 
        mainAxisSpacing: 8.0, 
        crossAxisSpacing: 8.0,
        padding: EdgeInsets.all(8.0), 
        children: doctors.map((doctor) => DoctorCard(doctor: doctor)).toList(),
      ),
    );
  }
}
