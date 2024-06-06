import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<bool> comparePassword(String email, String password) async {
    final url = Uri.parse('$baseUrl/comparePassword');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['isPasswordValid'];
    } else {
      throw Exception('Error ejecutando la consulta: ${response.statusCode}');
    }
  }

  static Future<bool> insertarUsuario(
      String nombre, String email, String password) async {
    final url = Uri.parse('$baseUrl/insertarUsuario');
    final body =
    jsonEncode({'nombre': nombre, 'email': email, 'contraseña': password});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // El usuario se insertó exitosamente
        return true;
      } else {
        // Ocurrió un error al insertar el usuario
        return false;
      }
    } catch (e) {
      // Error de conexión
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> isAdmin(String email) async {
    final url = Uri.parse('$baseUrl/esAdmin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['isAdmin'];
    } else {
      throw Exception('Error al verificar si el usuario es administrador');
    }
  }

  static Future<String?> getMenuName(int idMenu) async {
    final response = await http.get(Uri.parse('$baseUrl/nombreMenu/$idMenu'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['nombre'];
    } else {
      throw Exception('Error al obtener el nombre del menú');
    }
  }

  static Future<bool> isMenuActive(int idMenu) async {
    final response = await http.get(Uri.parse('$baseUrl/menuActivo/$idMenu'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['activo'];
    } else {
      throw Exception('Error al obtener el estado del menú');
    }
  }

  static Future<String?> getSubmenuName(int idMenu) async {
    final response =
    await http.get(Uri.parse('$baseUrl/nombreSubmenu/$idMenu'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['nombre'];
    } else {
      throw Exception('Error al obtener el nombre del menú');
    }
  }

  static Future<bool> isSubmenuActive(int idMenu) async {
    final response =
    await http.get(Uri.parse('$baseUrl/submenuActivo/$idMenu'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['activo'];
    } else {
      throw Exception('Error al obtener el estado del menú');
    }
  }
}
