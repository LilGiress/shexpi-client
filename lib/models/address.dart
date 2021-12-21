// class Address {
//   String placeFormattedAddress;
//   String placeName;
//   String placeId;
//   double latitude;
//   double longitude;

//   Address(
//       {   this.placeFormattedAddress,
//          this.placeName,
//           this.placeId,
//         this.latitude,
//          this.longitude});
// }

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';


class Address {
   String id;
   String name;
  final String surname;
  final String email;
   bool atMyPlace;
  final bool isCompany;
   String address;
   String addressId;
   double latitude;
  double longitude;
  final String country;
  final String timezone;
   String city;
  final String apartmentSuiteFloor;
  final String postalCode;
  final String phone;
  final String details;
  final String type;
  final String company;
  bool isCurrent;

  Address(
      {
       this.id,
       this.name,
       this.surname,
       this.email,
       this.atMyPlace,
       this.isCompany,
       this.address,
       this.addressId,
       this.latitude,
       this.longitude,
       this.country,
       this.city,
       this.postalCode,
       this.timezone,
       this.phone,
       this.apartmentSuiteFloor,
       this.details,
       this.type,
       this.company,
       this.isCurrent});

  bool isUnknown() {
    return latitude == null || longitude == null || address == null;
  }

  factory Address.fromJSON(Map<String, dynamic> jsonData) {
    return Address(
      id: jsonData['id'] != null ? jsonData['id'].toString() : null,
      name: jsonData['name'] != null ? jsonData['name']: null,
      surname: jsonData['surname'] != null ? jsonData['surname']: null,
      email: jsonData['email'] != null ? jsonData['email']: null,
      atMyPlace: jsonData['at_my_place'],
      isCompany: jsonData['is_company'],
      address: jsonData['address'],
      addressId: jsonData['address_id'],
      latitude: jsonData['latitude'] != null
          ? double.parse(jsonData['latitude'].toString())
          : null,
      longitude: jsonData['longitude'] != null
          ? double.parse(jsonData['longitude'].toString())
          : null,
      country: jsonData['country'],
      city: jsonData['city'],
      postalCode: jsonData['postal_code'],
      timezone: jsonData['timezone'],
      phone: jsonData['phone'],
      apartmentSuiteFloor: jsonData['apartment_suite_floor'],
      details: jsonData['details'],
      type: jsonData['type'],
      company: jsonData['company'], isCurrent: null,
    );
  }

  static String encode(List<Address> addresses) => json.encode(
        addresses
            .map<Map<String, dynamic>>((music) => Address.toMap(music))
            .toList(),
      );

  static List<Address> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Address>((item) => Address.fromJSON(item))
          .toList();

  static Map<String, dynamic> toMap(Address address) => {
        'latitude': address.latitude,
        'longitude': address.longitude,
        'address': address.address,
        'country': address.country,
        'city': address.city,
        'postalCode': address.postalCode,
        'addressId': address.addressId,
        'timezone': address.timezone,
        'place_id':address.id,
      };
}
