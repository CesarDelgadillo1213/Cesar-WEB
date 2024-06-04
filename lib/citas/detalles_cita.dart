import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_web/api_service.dart';
import 'package:login_web/citas/cita.dart';
import 'package:login_web/citas/ver_citas.dart'; // Importa la pantalla de VerCitas

class DetallesCita extends StatelessWidget {
  final Cita cita;
  final ApiService apiService;

  const DetallesCita({Key? key, required this.cita, required this.apiService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAdminStatus(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          // Check if isAdmin is true
          return _buildWithAdminButton(
              context); // Show the details with admin button
        } else {
          return _buildWithDoctorButton(
              context); // Show the details with doctor button
        }
      },
    );
  }

  Future<bool> _checkAdminStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdmin') ??
        false; // Default to false if isAdmin is not set
  }

  Widget _buildWithAdminButton(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de la cita',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 148, 27, 27),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appointment ID section with card-like styling
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.only(bottom: 15.0),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID de la cita:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      '${cita.idCita}',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            // Patient section with clear labeling and divider
            Text(
              'Paciente:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              '${cita.nombrePaciente}',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Divider(thickness: 1.0), // Divider for visual separation

            // Date section with consistent formatting and divider
            Text(
              'Fecha:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              '${cita.fecha}',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Divider(thickness: 1.0),

            // Time section with potential icon and divider
            Text(
              'Hora:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.access_time_rounded, color: Colors.black87),
                const SizedBox(width: 5.0),
                Text(
                  '${cita.hora}',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const Divider(thickness: 1.0),

            // Doctor section with conditional presence, clear label, and divider
            if (cita.nombreMedico != null && cita.nombreMedico!.isNotEmpty) ...[
              Text(
                'Médico:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                '${cita.nombreMedico}',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const Divider(thickness: 1.0), // Divider for visual separation
            ],

            // Delete button
            ElevatedButton(
              onPressed: () async {
                // Verificar si la cita ya ha pasado
                if (cita.fecha.isBefore(DateTime.now())) {
                  // Si la fecha de la cita es anterior a la fecha actual, mostrar un mensaje de error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'No se puede eliminar una cita que ya ha pasado'),
                    ),
                  );
                } else {
                  // Si la cita aún no ha pasado, proceder con la eliminación
                  await apiService.deleteCita(cita.idCita);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cita eliminada con éxito'),
                    ),
                  );

                  // Regresar a la pantalla anterior
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => VerCitas()),
                  );
                }
              },
              child: Text('Eliminar'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithDoctorButton(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de la cita',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appointment ID section with card-like styling
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.only(bottom: 15.0),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID de la cita:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      '${cita.idCita}',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            // Patient section with clear labeling and divider
            Text(
              'Paciente:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              '${cita.nombrePaciente}',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Divider(thickness: 1.0), // Divider for visual separation

            // Date section with consistent formatting and divider
            Text(
              'Fecha:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              '${cita.fecha}',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Divider(thickness: 1.0),

            // Time section with potential icon and divider
            Text(
              'Hora:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.access_time_rounded, color: Colors.black87),
                const SizedBox(width: 5.0),
                Text(
                  '${cita.hora}',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const Divider(thickness: 1.0),

            // Doctor section with conditional presence, clear label, and divider
            if (cita.nombreMedico != null && cita.nombreMedico!.isNotEmpty) ...[
              Text(
                'Médico:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                '${cita.nombreMedico}',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const Divider(thickness: 1.0), // Divider for visual separation
            ],

            // View history button
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Align buttons to opposite ends
              children: [
                // View history button
                ElevatedButton(
                  onPressed: () {
                    // Lógica para ver el historial médico
                  },
                  child: Text('Ver historial médico'),
                ),

                // Add diagnosis button
                ElevatedButton(
                  onPressed: () {
                    // Lógica para agregar el diagnóstico
                  },
                  child: Text('Agregar el diagnóstico'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
