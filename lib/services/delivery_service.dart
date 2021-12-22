import 'package:flutter/material.dart';

import 'package:mycar/models/address.dart';
import 'package:mycar/models/delivery.dart';
import 'package:mycar/models/user.dart';
import 'package:mycar/services/auth.service.dart';
import 'package:mycar/services/http_client.dart';

import 'package:provider/provider.dart';

class DeliveryService with ChangeNotifier {
  final User user;

  final GlobalKey<ScaffoldState> scaffoldKey;

  User _authUser;
  Address address;
  Delivery delivery;
  bool _isLoading = false;

  List<Delivery> _deliveries = [];

  Delivery _delivery;

  DeliveryService(this.user, GlobalKey<ScaffoldState> scaffoldKey)
      : scaffoldKey = scaffoldKey;

  //Delivery get delivery => _delivery;

  bool get isLoading => _isLoading;

  List<Delivery> get deliveries => [..._deliveries];

  User get authUser {
    return _authUser;
  }

  Future<void> fetchDeliveries(BuildContext context) async {
    var authService = Provider.of<AuthService>(context, listen: false);

    final response =
        await Client.get('users/${authService.authUser.id}/deliveries');
    //final response = await AuthService.get('users/${auth.authUser.id}/deliveries');

    final extractedData = response as List<dynamic>;

    final List<Delivery> responseDeliveries = [];

    extractedData.forEach((element) {
      responseDeliveries
          .add(Delivery.fromJSON(element as Map<String, dynamic>));
    });

    _deliveries = responseDeliveries;

    _isLoading = false;

    notifyListeners();
  }

  Future<Delivery> findById(BuildContext context, String deliveryId) async {
    var authService = Provider.of<AuthService>(context, listen: false);

    final response = await Client.get(
        'users/${authService.authUser.id}/deliveries/$deliveryId');

    final Delivery extractedData = Delivery.fromJSON(response);

    if (response != null) {
      _delivery = extractedData;
    }
    notifyListeners();

    //return response != null ? extractedData : null;
  }

  Future<void> store(Map<String, dynamic> delivery, context) async {
    var authService = Provider.of<AuthService>(context, listen: false);

    final response =
        await Client.post('users/${authService.authUser.id}/deliveries');

    final Delivery extractedData = Delivery.fromJSON(response);

    if (response != null) {
      _delivery = extractedData;
    }
    notifyListeners();

    //return response != null ? extractedData : null;
  }
}
