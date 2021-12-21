import 'package:flutter/material.dart';

class CurrencyExchangeRate {
  final double rate;
  final double convert;

  CurrencyExchangeRate({
   @required this.rate,
   @required this.convert
  });
}

class CurrencyModel {
  final String currency;
  final String text;
  final String isoCode;
  final double increment;
  final double min;
  final double max;
  final bool activated;
  final CurrencyExchangeRate exchangeRate;

  CurrencyModel({
    @required this.currency,
    @required this.text,
    @required this.isoCode,
    @required this.increment,
    @required this.min,
    @required this.max,
    @required this.activated,
    @required this.exchangeRate,
  });


  factory CurrencyModel.fromJSON(Map<String, dynamic> jsonMap) {

    return CurrencyModel(
        currency: jsonMap['currency'],
        text: jsonMap['text'],
        isoCode: jsonMap['ico_code'],
        increment: double.parse(jsonMap['increment'].toString()),
        min: double.parse(jsonMap['min'].toString()),
        max: double.parse(jsonMap['max'].toString()),
        activated: jsonMap['max'].toString() == "1" ? true : false,
        exchangeRate: CurrencyExchangeRate(
          rate: double.parse(jsonMap['exchange_rate']['rate'].toString()),
          convert: double.parse(jsonMap['exchange_rate']['convert'].toString()),
        )
    );
  }
}