import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:mycar/Language/appLocalizations.dart';

class PaymentMethod extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaymentMethodState();
  }
}

String getValidationError(String field) {
  if (validationError == null || validationError[field] == null) {
    return null;
  }

  return validationError[field][0];
}

@override
void dispose() {
  phoneFocusNode.dispose();
}

final phoneFocusNode = FocusNode();
var validationError;
String countryCode = "+237";
String pays;
var phoneTextEditingController = TextEditingController();
@override
void initState() {}

class _PaymentMethodState extends State<PaymentMethod> {
  String countryCode = "+237";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: <Widget>[
            Text(
              "Payer la demande de livraison",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 20),
            ),
            //  Padding(padding: EdgeInsets.all(8.0),
            //  child: Text('Paiement',style: TextStyle(color: Colors.black,fontFamily: "regular",
            //  fontStyle: FontStyle.normal,fontSize: 18),

            //  ),

            //  ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Vous serez facturé de 2408.1 XAF des la prise en charge de la livraison.',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "regular",
                  fontStyle: FontStyle.normal,
                  fontSize: 16),
            ),
            SizedBox(height: 40.0),
            ExpansionTile(
              title: Text(
                "MOBIL MONEY",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(38)),
                      border: Border.all(
                          color: Theme.of(context).dividerColor, width: 0.6),
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 70,
                          height: 50,
                          child: CountryCodePicker(
                            onChanged: (e) {
                              setState(() {
                                countryCode = e.dialCode;
                              });
                            },
                            initialSelection: 'cm',
                            showFlagMain: true,
                            showFlag: true,
                            favorite: ['+237', 'cm'],
                          ),
                        ),
                        Container(
                          color: Theme.of(context).dividerColor,
                          height: 30,
                          width: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, right: 16),
                            child: Container(
                              height: 40,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(
                                        'Numero de telephone invalide');
                                  }

                                  if (value.length < 9) {
                                    return AppLocalizations.of(
                                        'Doit être au moins de 9 chiffres');
                                  }
                                  return getValidationError(value);
                                },
                                controller: phoneTextEditingController,
                                focusNode: phoneFocusNode,
                                maxLines: 1,
                                onChanged: (String txt) {
                                  var phoneNumber = txt;
                                },
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: new InputDecoration(
                                  errorText: null,
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(
                                      "Numero de téléphone "),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context).disabledColor),
                                ),
                                keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[],

                                //  onSaved: (String value){
                                //   phoneTextEditingController = value as TextEditingController;
                                // },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: FlatButton(
                        // borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of('Payer'),
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionTile(
              title: Text(
                "PAYPAL/CARTE BANCAIRE",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(38)),
                      border: Border.all(
                          color: Theme.of(context).dividerColor, width: 0.6),
                    ),
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: TextButton(
                              onPressed: () => {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UsePaypal(
                                                sandboxMode: true,
                                                clientId:
                                                    "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                                                secretKey:
                                                    "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                                                returnURL:
                                                    "https://samplesite.com/return",
                                                cancelURL:
                                                    "https://samplesite.com/cancel",
                                                transactions: const [
                                                  {
                                                    "amount": {
                                                      "total": '10.12',
                                                      "currency": "USD",
                                                      "details": {
                                                        "subtotal": '10.12',
                                                        "shipping": '0',
                                                        "shipping_discount": 0
                                                      }
                                                    },
                                                    "description":
                                                        "The payment transaction description.",
                                                    // "payment_options": {
                                                    //   "allowed_payment_method":
                                                    //       "INSTANT_FUNDING_SOURCE"
                                                    // },
                                                    "item_list": {
                                                      "items": [
                                                        {
                                                          "name":
                                                              "A demo product",
                                                          "quantity": 1,
                                                          "price": '10.12',
                                                          "currency": "USD"
                                                        }
                                                      ],

                                                      // shipping address is not required though
                                                      "shipping_address": {
                                                        "recipient_name":
                                                            "Jane Foster",
                                                        "line1":
                                                            "Travis County",
                                                        "line2": "",
                                                        "city": "Austin",
                                                        "country_code": "US",
                                                        "postal_code": "73301",
                                                        "phone": "+00000000",
                                                        "state": "Texas"
                                                      },
                                                    }
                                                  }
                                                ],
                                                note:
                                                    "Contact us for any questions on your order.",
                                                onSuccess: (Map params) async {
                                                  print("onSuccess: $params");
                                                },
                                                onError: (error) {
                                                  print("onError: $error");
                                                },
                                                onCancel: (params) {
                                                  print('cancelled: $params');
                                                }),
                                      ),
                                    )
                                  },
                              child: const Text("Payement par Paypal")),
                        )
                      ],
                    ),
                  ),
                ),
                //SizedBox(height: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
