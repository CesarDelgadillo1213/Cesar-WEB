class Doctor {
  final int id;
  final String nombres;
  final String apellidos;
  final List<String> especialidades;
  final String descripcion;
  final String username;

  Doctor({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.especialidades,
    required this.descripcion,
    required this.username,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      especialidades: List<String>.from(json['especialidades']),
      descripcion: json['descripcion'],
      username: json['username'],
    );
  }
}
