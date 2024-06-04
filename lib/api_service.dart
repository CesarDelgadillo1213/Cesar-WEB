import 'dart:convert';
import 'dart:html';

import 'package:login_web/doctor/doctor.dart';
import 'package:login_web/citas/cita.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Asegúrate de importar la clase Cita si existe

class ApiService {
  Future<void> createMedico(
    String nombres,
    String apellidos,
    List<String> especialidades,
    String descripcion,
    String username,
    String password,
  ) async {
    try {
      var url = 'http://localhost:3000/medico/create';
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        'nombres': nombres,
        'apellidos': apellidos,
        'especialidades': especialidades,
        'descripcion': descripcion,
        'username': username,
        'password': password,
      });

      print('Enviando solicitud HTTP...');

      var response = await HttpRequest.request(
        url,
        method: 'POST',
        requestHeaders: headers,
        sendData: body,
      );

      print('Solicitud completada con éxito.');

      if (response.status == 201) {
        // Verificar si la solicitud fue exitosa (código de estado 201)
        print('Código de estado 201 - Éxito:');
        print(response.responseText);
        // Aquí puedes procesar el cuerpo de la respuesta según necesites
      } else {
        // Manejar otros códigos de estado según sea necesario
        print('Error en la respuesta:');
        print('Código de estado: ${response.status}');
        print('Mensaje: ${response.statusText}');
      }
    } catch (e) {
      print('Error en la solicitud:');
      print(e);
    }
  }

 Future<int?> login(String username, String password) async {
  try {
    final url = 'http://localhost:3000/medico/login';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    final response = await HttpRequest.request(url,
        method: 'POST', requestHeaders: headers, sendData: body);

    if (response.status == 200) {
      if (response.responseText != null) {
        try {
          final jsonResponse = jsonDecode(response.responseText!);
          final userId = jsonResponse['id'] as int?;

          if (userId != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('userId', userId);
            print('ID de usuario guardado en las preferencias compartidas: $userId');
          } else {
            print('Error: ID de usuario nulo en la respuesta JSON');
          }

          // Aquí puedes procesar el cuerpo de la respuesta según necesites

          return response.status; // Devuelve el estado de la respuesta
        } catch (e) {
          print('Error al decodificar la respuesta JSON: $e');
        }
      } else {
        print('La respuesta está vacía');
      }
    } else {
      print('Error en la respuesta:');
      print('Código de estado: ${response.status}');
      print('Mensaje: ${response.statusText}');

      if (response.status == 404) {
        print('Error en la respuesta: Credenciales inválidas');
      }
    }

    return response.status; // Devuelve el estado de la respuesta
  } catch (e) {
    print('Error en la solicitud:');
    print(e);
    return -1; // Devuelve -1 en caso de error
  }
}
  Future<List<Doctor>> getMedicos() async {
    try {
      var url = 'http://localhost:3000/medico';
      var headers = {'Content-Type': 'application/json'};

      var response = await HttpRequest.request(
        url,
        method: 'GET',
        requestHeaders: headers,
      );

      if (response.status == 200) {
        // Verificar que response.responseText no sea nulo
        if (response.responseText != null) {
          // Decodificar la respuesta JSON a una lista de mapas
          List<dynamic> jsonResponse = jsonDecode(response.responseText!);

          // Convertir cada mapa en un objeto Doctor y almacenarlo en una lista
          List<Doctor> doctors =
              jsonResponse.map((json) => Doctor.fromJson(json)).toList();

          return doctors;
        } else {
          throw Exception('La respuesta está vacía');
        }
      } else {
        throw Exception('Error en la respuesta');
      }
    } catch (e) {
      throw Exception('Error en la solicitud GET: $e');
    }
  }

  // Método para obtener la lista de citas desde la API
  Future<List<Cita>> getCitas() async {
    try {
      var url = 'http://localhost:3000/cita';
      var headers = {'Content-Type': 'application/json'};

      var response = await HttpRequest.request(
        url,
        method: 'GET',
        requestHeaders: headers,
      );

      if (response.status == 200) {
        if (response.responseText != null) {
          List<dynamic> jsonResponse = jsonDecode(response.responseText!);
          List<Cita> citas =
              jsonResponse.map((json) => Cita.fromJson(json)).toList();
          return citas;
        } else {
          throw Exception('La respuesta está vacía');
        }
      } else {
        throw Exception('Error en la respuesta');
      }
    } catch (e) {
      throw Exception('Error en la solicitud GET: $e');
    }
  }

  Future<List<Cita>> getCitasByDoctor(int doctorId) async {
    try {
      var url = 'http://localhost:3000/cita/medico?id_medico=$doctorId'; // Add doctor ID to query parameter
      var headers = {'Content-Type': 'application/json'};

      var response = await HttpRequest.request(
        url,
        method: 'GET',
        requestHeaders: headers,
      );

      if (response.status == 200) {
        if (response.responseText != null) {
          List<dynamic> jsonResponse = jsonDecode(response.responseText!);
          List<Cita> citas =
              jsonResponse.map((json) => Cita.fromJson(json)).toList();
          return citas;
        } else {
          throw Exception('La respuesta está vacía');
        }
      } else {
        throw Exception('Error en la respuesta');
      }
    } catch (e) {
      throw Exception('Error en la solicitud GET: $e');
    }
  }

  
  Future<void> deleteCita(int citaId) async {
  try {
    var url = 'http://localhost:3000/cita/$citaId'; // Reemplaza $citaId con el ID de la cita que deseas eliminar
    var headers = {'Content-Type': 'application/json'};

    var response = await HttpRequest.request(
      url,
      method: 'DELETE',
      requestHeaders: headers,
    );

    if (response.status == 200 || response.status == 204) {
      // La solicitud DELETE fue exitosa
      print('Cita eliminada correctamente');
    } else {
      throw Exception('Error en la respuesta: ${response.statusText}');
    }
  } catch (e) {
    throw Exception('Error en la solicitud DELETE: $e');
  }
}

  Future<List<Doctor>> getmedicologin() async {
    try {
      var url = 'http://localhost:3000/medico/login';
      var headers = {'Content-Type': 'application/json'};

      var response = await HttpRequest.request(
          url, method: 'GET', requestHeaders: headers);

      if (response.status == 200) {
        // Verificar que response.responseText no sea nulo
        if (response.responseText != null) {
          // Decodificar la respuesta JSON a una lista de mapas
          List<dynamic> jsonResponse = jsonDecode(response.responseText!);

          // Convertir cada mapa en un objeto Doctor y almacenarlo en una lista
          List<Doctor> doctors =
              jsonResponse.map((json) => Doctor.fromJson(json)).toList();

          return doctors;
        } else {
          throw Exception('La respuesta está vacía');
        }
      } else {
        throw Exception('Error en la respuesta');
      }
    } catch (e) {
      throw Exception('Error en la solicitud GET:$e');
    }
  }
}