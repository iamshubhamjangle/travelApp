import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:travel_design_app/model/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userName;
  // String _userId;
  // DateTime _expiryDate;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get userName {
    return _userName;
  }

  Future<void> signUp(String name, String password) async {
    return _authenticateSignUp(name, password);
  }

  Future<void> signIn(String name, String password) async {
    return _authenticateSignIn(name, password);
  }

  Future<void> _authenticateSignUp(String name, String password) async {
    final url = '[API_URL_FOR_ADDING_USER]';
    try {
      http.Response res = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: jsonEncode({
          "name": name,
          "password": password,
        }),
      );

      final responseData = jsonDecode(res.body);
      print(responseData);
      if (responseData['success'].toString() == 'false') {
        throw HttpException(responseData['msg']);
      }
    } catch (e) {
      print('In _authSignUp method $e');
      throw (e);
    }
  }

  Future<void> _authenticateSignIn(String name, String password) async {
    final url = '[API_URL_FOR_AUTHENTICATING_USER]';
    try {
      http.Response res = await http.post(
        url,
        headers: {"Content-type": "application/json"},
        body: jsonEncode({
          "name": name,
          "password": password,
        }),
      );

      final responseData = jsonDecode(res.body);
      print(responseData);
      if (responseData['success'].toString() == 'false') {
        throw HttpException(responseData['msg']);
      } else {
        _userName = responseData['name'].toString();
        print('Username: $_userName');
      }
    } catch (e) {
      print('In _authSignIN method $e');
      throw (e);
    }
  }
}
