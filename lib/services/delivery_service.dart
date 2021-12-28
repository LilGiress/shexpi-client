import 'package:flutter/material.dart';

import 'package:mycar/models/address.dart';
import 'package:mycar/models/delivery.dart';
import 'package:mycar/models/user.dart';
import 'package:mycar/services/auth.service.dart';
import 'package:mycar/services/http_client.dart';
import 'package:mycar/utilis/error/show_error.dart';

import 'package:provider/provider.dart';

class DeliveryService with ChangeNotifier {
  final List<Delivery> _deliveries = [];
  User user;
  User authUser;
  Address _address;
  Delivery _delivery;

  Delivery get delivery => _delivery;
  List<Delivery> get deliveries => [..._deliveries];
  // User get AuthService {
  //   return AuthService;
  // }

  // User get authUser {
  //   return authUser;
  // }

  // Future<void> fetchDeliveries(BuildContext context) async {
  //   var authService = Provider.of<AuthService>(context, listen: false);
  //   // ChangeNotifierProvider<DeliveryService>(
  //   //     create: (_) => DeliveryService(user, scaffoldKey));
  //   final response =
  //       await Client.get('users/${authService.authUser.id}/deliveries');
  //   //final response = await AuthService.get('users/${auth.authUser.id}/deliveries');

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

  // Future<void> findById(BuildContext context, String deliveryId) async {
  //   var authService = Provider.of<AuthService>(context, listen: false);

  //   final response = await Client.get(
  //       'users/${authService.authUser.id}/deliveries/$deliveryId');

  //   final Delivery extractedData = Delivery.fromJSON(response);

  //   if (response != null) {
  //     _delivery = extractedData;
  //   }
  //   notifyListeners();

  //   //return response != null ? extractedData : null;
  // }

  Future<void> store(Map<String, dynamic> delivery, context) async {
    ShowError.show('lllllllllllllllllllllllllllllllllll');
    //final authService = Provider.of<AuthService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final response =
        await Client.post('users/${authService.authUser.id}/deliveries');
    ShowError.show('lllllllllllllllllllllllllllllllllll');
    ShowError.show(response);

    final Delivery extractedData = Delivery.fromJSON(response);

    if (response != null) {
      _delivery = extractedData;
    }
    notifyListeners();

    //return response != null ? extractedData : null;
  }
}
