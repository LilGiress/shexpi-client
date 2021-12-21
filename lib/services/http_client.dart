import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mycar/Language/appLocalizations.dart';
import 'package:mycar/configuration/configMap.dart';
import 'package:mycar/modules/widgets/snackBar.dart';
import 'package:mycar/utilis/http/api_interceptor.dart';

class Client with ChangeNotifier {
  static final http = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);
  final GlobalKey<ScaffoldState> scaffoldKey;
  Client({this.scaffoldKey});
  ///////////////// reponse api
  static Future handleApiResponse(
      Future<Response> request, GlobalKey<ScaffoldState> scaffoldKey) async {
    var data;

    Response response;

    try {
      response = await request;

      if (response.statusCode == 200) {
        data = json.decode(response.body);
    
      } else {
        final errorData = json.decode(response.body);

        if (errorData['error'] != null && errorData['code'] != null) {
          throw HttpException(response.body);
        }

        return Future.error(
            "Error while fetching.", StackTrace.fromString("${response.body}"));
      }
    } on SocketException {
      if (scaffoldKey != null) {
        showSnackBarError(
            AppLocalizations.of('Verify your internet connection'),
            scaffoldKey);
      }

      return Future.error('No Internet connection');
    }

    return data;
  }

  static Uri parseUrl(String url) {
    return Uri.parse("${GlobalConfiguration().get('CallApi')}/$url");
  }

  static Future get(String url,
      {Map<String, String> body, GlobalKey<ScaffoldState> scaffoldKey}) async {
    return handleApiResponse(
        http.get(parseUrl(url), params: body ?? {}), scaffoldKey);
  }

  static Future post(String url,
      {Map<String, String> headers,
      dynamic body,
      GlobalKey<ScaffoldState> scaffoldKey}) async {
    return handleApiResponse(
        http.post(parseUrl(url), headers: headers ?? {}, body: body ?? {}),
        scaffoldKey);
  }
}
