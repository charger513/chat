import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  // final Usuario usuario;

  Future login(String email, String password) async {
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
  }
}
