import 'dart:convert';
import 'dart:developer';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  final _storage = FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
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

    print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(jsonDecode(resp.body));
      usuario = loginResponse.usuario;

      _guardarToken(loginResponse.token);

      success = true;
    }

    autenticando = false;
    return success;
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final uri = Uri.parse("${Environment.apiUrl}/login/new");

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(resp.body);

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(jsonDecode(resp.body));
      usuario = loginResponse.usuario;

      _guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logout() async {
    await _storage.delete(key: 'token');
  }
}
