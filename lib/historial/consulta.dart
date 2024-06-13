class Consulta {
  final int idCita;
  final int idMedico;
  final String diagnostico;
  final String recetaMedica;
  final String observaciones;
  final DateTime fecha;

  Consulta({
    required this.idCita,
    required this.idMedico,
    required this.diagnostico,
    required this.recetaMedica,
    required this.observaciones,
    required this.fecha,
  });

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      idCita: json['id_cita'],
      idMedico: json['id_medico'],
      diagnostico: json['diagnostico'],
      recetaMedica: json['receta_medica'],
      observaciones: json['observaciones'],
      fecha: DateTime.parse(json['fecha']),
    );
  }
}