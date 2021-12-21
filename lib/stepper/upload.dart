import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mycar/stepper/personnal.dart';

import 'contact.dart';
import 'planification.dart';

class Upload extends StatefulWidget {
  var mapInfo = HashMap<String, String>();

  Upload(this.mapInfo);

  @override
  State<StatefulWidget> createState() {
    return UploadState();
  }
}

class UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    var mapData = HashMap<String, String>();
    // mapData["name"] = PersonalState.nameTextEditingController.text;
    // mapData["surname"] = PersonalState.surnameTextEditingController.text;
    // mapData["email"] = PersonalState.emailTextEditingController.text;
    // mapData["phone"] = PersonalState.phoneTextEditingController.text;
    // mapData["address"] = PersonalState.ramassageAddressController.text;
    // mapData["password"] =
    //     PersonalState.confirmPasswordTextEditingController.text;

    // mapData["infoCourrier"] = PersonalState.infoCourTextEditingController.text;
    // mapData["descriptionLieu"] =
    //     PersonalState.descriptionTextEditingController.text;

    // mapData["name"] = ContactState.liVnameTextEditingController.text;
    // mapData["surname"] = ContactState.liVsurnameTextEditingController.text;
    // mapData["email"] = ContactState.liVemailTextEditingController.text;
    // mapData["phone"] = ContactState.liVphoneTextEditingController.text;
    // mapData["address"] = ContactState.liVAddressController.text;

    // mapData["infoCourrier"] =
    //     ContactState.liVinfoCourTextEditingController.text;
    // mapData["descriptionLieu"] =
    //     ContactState.liVdescriptionTextEditingController.text;

    mapData["planing"] = PlanificationRamassageState.Auto.toString();
    // mapData["planingJours"] = PlanificationRamassageState.deliveryHour;
    // mapData["planingHeure"] = PlanificationRamassageState.deliveryTime;

    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Name: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(mapData["first_name"], style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text(
                "Date of Birth: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              //Text(dob, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text(
                "Gender: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              //Text(gender, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text(
                "Email: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              //Text(email, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text(
                "Address: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              //Text(address, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text(
                "Mobile No: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              //Text(mobile, style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
