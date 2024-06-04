import 'package:flutter/material.dart';
import 'package:login_web/api_service.dart'; 
import 'package:login_web/doctor/doctor.dart';
import 'package:login_web/doctor/doctor_card.dart';
import 'package:login_web/doctor/detallesdoctor.dart';

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
        children: doctors.map((doctor) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailsScreen(doctor: doctor),
                ),
              );
            },
            child: DoctorCard(doctor: doctor),
          );
        }).toList(),
      ),
    );
  }
}

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;

  DoctorDetailsScreen({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Doctor'),
        backgroundColor: Color.fromARGB(255, 148, 27, 27),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 300.0,
                width: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://t3.ftcdn.net/jpg/02/48/87/00/360_F_248870078_Wuf8dA4IVf1SB8aH9Ah0HMNYOCNun479.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Doctor's name
            Text(
              'Nombre:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              '${doctor.nombres}',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20.0),
            // Doctor's specialization
            Text(
              'Especialidad:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              '${doctor.especialidades}',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20.0),
            // Doctor's experience
            Text(
              'Experiencia:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              '${doctor.descripcion} años',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

