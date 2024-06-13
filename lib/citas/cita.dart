class Cita {
  final int idCita;
  final int idMedico;
  final String nombreMedico;
  final String nombrePaciente;
  final int idPaciente; // Agregado el idPaciente
  final DateTime fecha;
  final String hora;

  Cita({
    required this.idCita,
    required this.idMedico,
    required this.nombreMedico,
    required this.nombrePaciente,
    required this.idPaciente, // Agregado el idPaciente
    required this.fecha,
    required this.hora,
  });

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      idCita: json['id_cita'],
      idMedico: json['id_medico'],
      nombreMedico: json['nombre_medico'],
      nombrePaciente: json['nombre_paciente'],
      idPaciente: json['id_paciente'], // Asignando el idPaciente
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
      'id_paciente': idPaciente, // Incluyendo el idPaciente en la serialización
      'fecha': fecha.toIso8601String(),
      'hora': hora,
    };
  }
}



class HistorialMedico {
  final int idCita;
  final String diagnostico;
  final String recetaMedica;
  final String observaciones;

  HistorialMedico({
    required this.idCita,
    required this.diagnostico,
    required this.recetaMedica,
    required this.observaciones,
  });

  factory HistorialMedico.fromJson(Map<String, dynamic> json) {
    return HistorialMedico(
      idCita: json['id_cita'],
      diagnostico: json['diagnostico'],
      recetaMedica: json['receta_medica'],
      observaciones: json['observaciones'],
    );
  }
}
