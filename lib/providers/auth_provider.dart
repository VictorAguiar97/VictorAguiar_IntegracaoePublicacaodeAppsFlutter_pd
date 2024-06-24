import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? message;
  String? token;
  String? action;

  final _url = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  final _apiKey = '?key=AIzaSyAIJ2VXhiQRjwYLnyaQ8w2PyYiAc0lf1jo';

  Future<bool> authRequest(String email, String password, String action) async {
    // ignore: non_constant_identifier_names
    String Urii = '$_url$action$_apiKey';
    Uri uri = Uri.parse(Urii);

    var response = await http.post(uri, body: {
      'email': email,
      'password': password,
      'returnSecureToken': '1',
    });

    var resp = jsonDecode(response.body);
    if (response.statusCode == 200) {
      message = "Usuário cadastrado com sucesso!";
      token = resp["idToken"];
      return true;
    } else {
      message = "Não foi possivel cadastrar usuario!";
      //print(response.body);
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    return authRequest(email, password, 'signUp');
  }

  Future<bool> signIn(String email, String password) async {
    return authRequest(email, password, 'signInWithPassword');
  }
}
