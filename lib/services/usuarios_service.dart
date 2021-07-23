import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');
      final token = await AuthService.getToken();

      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token!,
      });

      final usuariosResponse =
          UsuariosResponse.fromJson(jsonDecode(response.body));

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
