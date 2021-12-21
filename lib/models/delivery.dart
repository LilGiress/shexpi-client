import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../models/user.dart';
import '../models/address.dart';
import '../models/tracking.dart';

class Delivery {
  final String id;
  final User userId;
  final String deliveryId;
  final String deliveryTimezone;
  final DateTime deliveryTime;
  final double deliveryDistance;
  final double deliveryFees;
  final double deliveryTravelTime;
  final String currency;
  final bool deliveryAsap;
  final String status;
  final Tracking courier;
  final Address pickupAddress;
  final Address deliveryAddress;
  final DateTime payerAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Delivery(
      {this.id,
      this.userId,
      this.deliveryId,
      this.deliveryTimezone,
      this.deliveryTime,
      this.deliveryDistance,
      this.deliveryFees,
      this.deliveryTravelTime,
      this.currency,
      this.deliveryAsap,
      this.status,
      this.courier,
      this.pickupAddress,
      this.deliveryAddress,
      this.payerAt,
      this.createdAt,
      this.updatedAt});

  factory Delivery.fromJSON(Map<String, dynamic> jsonMap) {
    final amount = double.parse(jsonMap['delivery_fees'].toString());
    return Delivery(
      id: jsonMap['id'].toString(),
      userId: User.fromJSON(jsonMap['user_id']),
      deliveryId: jsonMap['delivery_id'].toString(),
      deliveryTimezone: jsonMap['delivery_timezone'],
      deliveryTime: jsonMap['delivery_time'] != null
          ? DateTime.parse(jsonMap['delivery_time'])
          : null,
      deliveryDistance: jsonMap['delivery_distance'] != null
          ? double.parse(jsonMap['delivery_distance'].toString())
          : null,
      deliveryFees:
          jsonMap['delivery_fees'] != null ? (amount * 100).ceil() / 100 : null,
      deliveryTravelTime: jsonMap['delivery_travel_time'] != null
          ? double.parse(jsonMap['delivery_travel_time'].toString())
          : null,
      currency: jsonMap['currency'],
      deliveryAsap: jsonMap['delivery_asap'],
      status: jsonMap['status'],
      courier: Tracking.fromJSON(jsonMap['courier']),
      pickupAddress: Address.fromJSON(jsonMap['pickup_address']),
      deliveryAddress: Address.fromJSON(jsonMap['delivery_address']),
      payerAt: jsonMap['payerAt'] != null
          ? DateTime.parse(jsonMap['payerAt'])
          : null,
      createdAt: jsonMap['createdAt'] != null
          ? DateTime.parse(jsonMap['createdAt'])
          : null,
      updatedAt: jsonMap['updatedAt'] != null
          ? DateTime.parse(jsonMap['updatedAt'])
          : null,
    );
  }
}
