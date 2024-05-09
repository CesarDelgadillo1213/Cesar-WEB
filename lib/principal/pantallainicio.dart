// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_web/doctor/list_doctors.dart';
import 'package:login_web/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../doctor/admin.dart';
import '../citas/Ver_Citas.dart';

class PantallaInicio extends StatefulWidget {
  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'MED EASE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 43,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: <Color>[Colors.greenAccent, Colors.green],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF700F1C),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                _cerrarSesion(); // Llama a la función para cerrar sesión
              },
            ),
          ]),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://cdn.treedis.com/tours/49139/images/2f92e177-4e19-4287-bb8f-c9f32b78b0a1_small.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuCard(
                  context,
                  Icons.add_circle,
                  'Agregar Doctores',
                  'Agregar nuevos doctores',
                  Colors.blue,
                  PostMedicoPage(),
                ),
                _buildMenuCard(
                  context,
                  Icons.list,
                  'Doctores Agregados',
                  'Ver la lista de doctores',
                  Colors.green,
                  DoctorProfile(),
                ),
                _buildMenuCard(
                  context,
                  Icons.calendar_today,
                  'Ver Citas',
                  'Visualiza las citas confirmadas',
                  Colors.orange,
                  VerCitas(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, IconData icon, String title,
      String subtitle, Color color, Widget route) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.9),
              color,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cerrarSesion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Elimina todas las SharedPreferences
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false, // Elimina todas las rutas en el stack
    );
  }
}
