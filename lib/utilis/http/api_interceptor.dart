import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({ RequestData data}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
     
      if (prefs.containsKey('currentToken')) {
       
        final extractedCurrentToken = json.decode(prefs.getString('currentToken')) as Map<String, Object>;
  
        final expiryDate = DateTime.parse(extractedCurrentToken['expiryDate']);

        if (expiryDate.isAfter(DateTime.now())) {
          data.headers["Authorization"] = extractedCurrentToken['token'];
        }
      }

    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ ResponseData data}) async => data;
}