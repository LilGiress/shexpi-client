import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mycar/models/user.dart';
import 'package:mycar/services/http_client.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey;
  AuthService({this.scaffoldKey});
  final tokenKey = 'currentToken';
  String _token;
  DateTime _expiryDate;
  User _authUser;
  Timer _authTimer;

  //////
  ///
////to get token
  ///
  ///
  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  User get authUser {
    return _authUser;
  }

  Future<void> register(Map<String, dynamic> userData) async {
    Map<String, String> header = {"Content-Type": "application/json"};

    await Client.post('auth/signup',
        headers: header, body: jsonEncode(userData));

    await login(userData['email'], userData['password']);
  }

  Future<void> login(String email, String password) async {
    final tokenResponse = await Client.post('auth/signin', body: {
      'email': email,
      'password': password,
      'with_credentials': 'true'
    });

    await _authenticate(tokenResponse);
  }

  Future<void> _authenticate(dynamic tokenResponse) async {
    _token = tokenResponse['accessToken'];

    int h, m, s;

    h = tokenResponse['tokenExpiresIn'] ~/ 3600;

    m = ((tokenResponse['tokenExpiresIn'] - h * 3600)) ~/ 60;

    s = tokenResponse['tokenExpiresIn'] - (h * 3600) - (m * 60);

    DateTime newDate = DateTime.now();

    DateTime formatedDate =
        newDate.add(Duration(hours: h, minutes: m, seconds: s));

    _expiryDate = formatedDate;

    _autoLogout();

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    final tokenData = json
        .encode({'token': _token, 'expiryDate': _expiryDate.toIso8601String()});

    prefs.setString(tokenKey, tokenData);
    _authUser = await getUserData();
  }

  Future<User> getUserData() async {
    final userRequest = Client.http.get(Client.parseUrl('users/me'));

    final userData = await Client.handleApiResponse(userRequest, scaffoldKey);

    return User.fromJSON(userData);
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> logout() async {
    _token = null;
    _authUser = null;

    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(tokenKey);
    await Future.delayed(Duration(seconds: 2));
  }
}
