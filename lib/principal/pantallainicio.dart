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

class _PantallaInicioState extends State<PantallaInicio> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<bool> _isVisible = List.generate(4, (_) => false);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..forward();

    for (int i = 0; i < 4; i++) {
      Future.delayed(Duration(milliseconds: 300 * i), () {
        setState(() {
          _isVisible[i] = true;
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                colors: <Color>[Colors.greenAccent, Color.fromARGB(255, 255, 255, 255)],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF700F1C),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              _cerrarSesion();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1661758899958-050ce4481f35?q=80&w=1954&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  color: Colors.black.withOpacity(0.5),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    Center(
                      child: Text(
                        'TU SALUD, TU TIEMPO, EN CONTROL',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Builder(
                      builder: (context) => ElevatedButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                            'Comenzar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 161, 193, 162)),
                          elevation: MaterialStateProperty.all<double>(5),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
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
                children: [
                  Center(
                    child: Text(
                      'MED EASE',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF700F1C),
                        fontFamily: 'Georgia',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Toma el control de tus citas y doctores: organización personalizada y atención al paciente optimizada',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.8,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Transforma tu experiencia en salud. Nuestras instalaciones de última generación y tecnologías de vanguardia nos permiten brindar tratamientos completos y atención personalizada, adaptados a tus necesidades únicas.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.8,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
                image: DecorationImage(
                  image: NetworkImage('https://www.transparenttextures.com/patterns/medical-icons.png'),
                  repeat: ImageRepeat.repeat,
                  opacity: 0.1,
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Beneficios y Características',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF700F1C),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FadeTransition(
                              opacity: Tween<double>(begin: 0, end: 1).animate(_controller),
                              child: _buildBenefitItem(Icons.access_time, 'Gestión de Tiempo', 'Optimiza tu tiempo con nuestras herramientas.', 0),
                            ),
                            SizedBox(height: 20),
                            FadeTransition(
                              opacity: Tween<double>(begin: 0, end: 1).animate(_controller),
                              child: _buildBenefitItem(Icons.medical_services, 'Atención Personalizada', 'Atención médica a tu medida.', 1),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            FadeTransition(
                              opacity: Tween<double>(begin: 0, end: 1).animate(_controller),
                              child: _buildBenefitItem(Icons.location_city, 'Instalaciones Modernas', 'Tecnología de vanguardia.', 2),
                            ),
                            SizedBox(height: 20),
                            FadeTransition(
                              opacity: Tween<double>(begin: 0, end: 1).animate(_controller),
                              child: _buildBenefitItem(Icons.security, 'Seguridad', 'Privacidad de datos garantizada.', 3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF700F1C),
              ),
              child: Text(
                'Selecciona una Opcion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            //ListTile(
              //leading: Icon(Icons.add_circle, color: Colors.blue),
              //title: Text('Agregar Doctores'),
              //onTap: () {
                //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => PostMedicoPage()),
                //);
             // },
            //),
            ListTile(
              leading: Icon(Icons.list, color: Colors.green),
              title: Text('Doctores Agregados'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorProfile()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.orange),
              title: Text('Ver Citas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerCitas()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String description, int index) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: _isVisible[index] ? 1.0 : 0.0,
      child: Row(
        children: [
          Icon(icon, size: 40, color: Color.fromARGB(255, 161, 193, 162)),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.3,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _cerrarSesion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }
}