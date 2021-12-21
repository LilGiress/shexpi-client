import 'package:flutter/material.dart';
import 'package:mycar/Language/appLocalizations.dart';

import 'contact.dart';
import 'personnal.dart';

class Recapitulatif extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecapitulatifState();
  }

  static final formKey = GlobalKey<FormState>();
}

final myImageAndCaption = [
  ["assets/images/intro_3.png", "Lieu de ramassage"],
  ["assets/images/intro_2.png", "Date de ramassage"],
  ["assets/images/intro_3.png", "Lieu de Livraison"],
  // ["assets/images/banane.jpg", "This is almost a bigger text"],
  // ["assets/images/banane.jpg", "oh no this a really really big text"],
  // ["assets/images/banane.jpg", "yes small one"],
  // ["assets/images/banane.jpg", "yes"],
];
bool isSignUp = true;

class _RecapitulatifState extends State<Recapitulatif> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "Récapitulatif de votre demande de livraison de colis",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/intro_3.png',
                        ),
                        Text(
                          'Lieu de ramassage',
                          style: TextStyle(),
                        ),
                        SizedBox(height: 20),
                        // Text(PersonalState.ramassageAddressController.text,
                        //     style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/images/intro_2.png'),
                        Text('Date de ramassage'),
                        SizedBox(height: 20),
                        // Text(PersonalState.ramassageAddressController.text,
                        //     style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/images/intro_3.png'),
                        Text('Lieu de Livraison'),
                        SizedBox(height: 20),
                        // Text(liVAddressController.text,
                        //    style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }
}
