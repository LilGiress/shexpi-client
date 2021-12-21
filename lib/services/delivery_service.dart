import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:mycar/models/address.dart';
import 'package:mycar/models/delivery.dart';
import 'package:mycar/models/user.dart';

import 'package:mycar/utilis/http/api_interceptor.dart';
import 'package:provider/provider.dart';

import 'auth.service.dart';
import 'http_client.dart';

class DeliveryService with ChangeNotifier {
  static final http = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);
  final GlobalKey<ScaffoldState> scaffoldKey;
  DeliveryService({this.scaffoldKey});

  User _authUser;
  Address address;
  Delivery delivery;
  bool _isLoading = false;

  List<Delivery> _deliveries = [];

  Delivery _delivery;

  //Delivery get delivery => _delivery;

  bool get isLoading => _isLoading;

  List<Delivery> get deliveries => [..._deliveries];

  User get authUser {
    return _authUser;
  }

  Future<void> store(Map<String, dynamic> delivery) async {
    Map<String, String> header = {"Content-Type": "application/json"};

    await Client.post('users/:userId/deliveries',
        headers: header, body: jsonEncode(delivery));

    notifyListeners();
  }

  Future<void> register(Map<String, dynamic> userData) async {
    Map<String, String> header = {"Content-Type": "application/json"};

    await Client.post('auth/signup',
        headers: header, body: jsonEncode(userData));

    //await login(userData['email'], userData['password']);
  }

  // Deliveries(this.user);

  // Future<void> fetchDeliveries(BuildContext context) async {
  //   var auth = Provider.of<AuthService>(context, listen: false);

  //   final response = await AuthService.get('users/${auth.authUser.id}/deliveries');

  //   final extractedData = response as List<dynamic>;

  //   final List<Delivery> responseDeliveries = [];

  //   extractedData.forEach((element) {
  //     responseDeliveries
  //         .add(Delivery.fromJSON(element as Map<String, dynamic>));
  //   });

  //   _deliveries = responseDeliveries;

  //   _isLoading = false;

  //   notifyListeners();
  // }

  // Future<Delivery> findById(BuildContext context, String deliveryId) async {
  //   var auth = Provider.of<AuthService>(context, listen: false);

  //   final response =
  //       await AuthService.get('users/${auth.authUser.id}/deliveries/$deliveryId');

  //   final Delivery extractedData = Delivery.fromJSON(response);

  //   if (response != null) {
  //     _delivery = extractedData;
  //   }
  //   notifyListeners();

  //   //return response != null ? extractedData : null;
  // }
}
