import 'dart:convert';
import 'dart:developer';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    bool success = false;

    final data = {
      'email': email,
      'password': password,
    };

    final uri = Uri.parse("${Environment.apiUrl}/login");

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(jsonDecode(resp.body));
      usuario = loginResponse.usuario;
      success = true;
    }

    autenticando = false;
    return success;
  }
}
