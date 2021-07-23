import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/usuario.dart';

class ChatService with ChangeNotifier {
  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioId) async {
    try {
      final uri = Uri.parse("${Environment.apiUrl}/mensajes/$usuarioId");
      final token = await AuthService.getToken();

      final response = await http.get(uri, headers: {
        'Content_Type': 'application/json',
        'x-token': token!,
      });

      final mensajesResponse =
          MensajesResponse.fromJson(jsonDecode(response.body));

      return mensajesResponse.mensajes;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
