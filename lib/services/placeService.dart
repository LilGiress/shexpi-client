import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mycar/utilis/error/show_error.dart';

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;
  String address;
  String placeId;
  String country;
  double latitude;
  double longitude;

  Place(
      {this.address,
      this.placeId,
      this.country,
      this.city,
      this.zipCode,
      this.streetNumber,
      this.street,
      this.latitude,
      this.longitude});

  @override
  String toString() {
    return 'Place(address: $address,streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  //final client = Client();

  PlaceApiProvider();

  // final sessionToken;

  static final String androidKey = 'AIzaSyDXr-tBvlC_BApCsY8NvZy4rFFss4nlxok';
  static final String iosKey = '';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$apiKey');
    final response = await get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["status"] == "OK") {
        // compose suggestions in a list
        return result["predictions"]
            .map<Suggestion>((p) => Suggestion(p["place_id"], p["description"]))
            .toList();
      }
      if (result["status"] == "ZERO_RESULTS") {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey');
    final response = await get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place();

        place.address = result['result']['formatted_address'];
        place.placeId = placeId;
        place.latitude =
            result['result']['geometry']['location']['lat'] as double;
        place.longitude =
            result['result']['geometry']['location']['lng'] as double;

        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('country')) {
            place.country = c['short_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['short_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  // Future<dynamic> getPlaceDetailFromId(String placeId) async {
  //   final request = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey');
  //   final response = await get(request);

  //   if (response.statusCode == 200) {
  //     final result = json.decode(response.body);

  //     if (result["status"] == "OK") {
  //       final components =
  //           result["result"]["address_components"] as List<dynamic>;
  //       // build result
  //       final place = Place();
  //       components.forEach((c) {
  //         final List type = c["types"];
  //         if (type.contains("street_number")) {
  //           place.streetNumber = c["long_name"];
  //         }
  //         if (type.contains("country")) {
  //           place.country = c["short_name"];
  //         }
  //         if (type.contains("route")) {
  //           place.street = c["long_name"];
  //         }
  //         if (type.contains("locality")) {
  //           place.city = c["long_name"];
  //         }
  //         if (type.contains("postal_code")) {
  //           place.zipCode = c["short_name"];
  //         }
  //       });

  //       return {
  //         "longitue": result["result"]["geometry"]["location"]["lng"],
  //         "address": result["result"]["formatted_address"],
  //         'latitude': result["result"]["geometry"]["location"]["lat"],
  //         'placeId': placeId,
  //         'streetNumber': place.streetNumber,
  //         'street': place.street,
  //         'city': place.city,
  //         'country': place.country,
  //         'zipCode': place.zipCode
  //       };
  //     }
  //     throw Exception(result['error_message']);
  //   } else {
  //     throw Exception('Failed to fetch suggestion');
  //   }
  // }
}
