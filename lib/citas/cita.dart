class Cita {
  final int idCita;
  final int idMedico;
  final String nombreMedico;
  final String nombrePaciente;
  final DateTime fecha;
  final String hora;

  Cita({
    required this.idCita,
    required this.idMedico,
    required this.nombreMedico,
    required this.nombrePaciente,
    required this.fecha,
    required this.hora,
  });

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      idCita: json['id_cita'],
      idMedico: json['id_medico'],
      nombreMedico: json['nombre_medico'],
      nombrePaciente: json['nombre_paciente'],
      fecha: DateTime.parse(json['fecha']),
      hora: json['hora'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cita': idCita,
      'id_medico': idMedico,
      'nombre_medico': nombreMedico,
      'nombre_paciente': nombrePaciente,
      'fecha': fecha.toIso8601String(),
      'hora': hora,
    };
  }
}
