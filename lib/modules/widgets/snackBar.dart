 import 'package:flutter/material.dart';

void showSnackBarError(
      String msg, GlobalKey<ScaffoldState> scaffoldKey) {
    ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }