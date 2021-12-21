import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycar/Language/appLocalizations.dart';
import 'package:mycar/constance/global.dart' as globals;
import 'package:mycar/modules/home/search.dart';
import 'package:mycar/services/auth.service.dart';
import 'package:mycar/services/placeService.dart';
import 'package:provider/provider.dart';

class Contact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactState();
  }
}

enum Singing { particulier, Entreprise }
enum Choice { moi, autre }

class ContactState extends State<Contact> {
  static final formKey = GlobalKey<FormState>();

  var liVnameTextEditingController = TextEditingController();
  var liVsurnameTextEditingController = TextEditingController();
  var villeTextEditingController = TextEditingController();
  var liVdescriptionTextEditingController = TextEditingController();
  var codePostalTextEditingController = TextEditingController();
  var societeTextEditingController = TextEditingController();
  var liVinfoCourTextEditingController = TextEditingController();

  var liVemailTextEditingController = TextEditingController();
  var liVAddressController = TextEditingController();

  var liVphoneTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    liVAddressController = TextEditingController();
    liVemailTextEditingController = TextEditingController();
    liVnameTextEditingController = TextEditingController();
    liVsurnameTextEditingController = TextEditingController();
    liVphoneTextEditingController = TextEditingController();
    liVinfoCourTextEditingController = TextEditingController();
    liVdescriptionTextEditingController = TextEditingController();
  }

  GoogleMapController mapController;
  String streetNumber = '';
  String street = '';
  String placeId = '';
  double latitude;
  double longitude;
  String city = '';
  String country = '';
  String zipCode = '';

  var validationError;
  Singing character = Singing.particulier;
  Choice itemData = Choice.moi;
  @override
  Widget build(BuildContext context) {
    globals.locale = Localizations.localeOf(context);
    final authService = Provider.of<AuthService>(context);
    return Material(
      child: Center(
          child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  "Livraison du colis",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 20),
                ),
              ],
            ),
            _ButtonColi(),
            _ButtonPerson(itemData),
            _societePerson(character, itemData),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('champ requise');
                  }

                  return getValidationError(value);
                },
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  hintText: 'Prenom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                controller: liVsurnameTextEditingController,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of('champ requise');
                }

                return getValidationError(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                hintText: 'Nom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              controller: liVnameTextEditingController,
            ),
            SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of('Numero de telephone invalide');
                }

                if (value.length < 9) {
                  return AppLocalizations.of(
                      'Doit être au moins de 9 chiffres');
                }
                return getValidationError(value);
              },
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.phone,
                  color: Colors.grey,
                ),
                hintText: 'Telephone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              controller: liVphoneTextEditingController,
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.mail,
                  color: Colors.grey,
                ),
                hintText: 'email',
                labelText: 'votre email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              validator: (value) {
                if (!value.contains('@')) {
                  return AppLocalizations.of(' email invalide');
                }
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of('champs requis');
                }
                return getValidationError(value);
              },
              controller: liVemailTextEditingController,
            ),
            SizedBox(height: 20),
            TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of('champ requise');
                  }
                  if (value.length < 2) {
                    return AppLocalizations.of('Should be more than 2 letters');
                  }
                  return null;
                },
                onTap: () async {
                  // generate a new token here
                  final Suggestion result = await showSearch(
                    context: context,
                    delegate:
                        AddressSearch(hintText: AppLocalizations.of('Search')),
                  );
                  // This will change the text displayed in the TextField
                  if (result != null) {
                    final placeDetails = await PlaceApiProvider()
                        .getPlaceDetailFromId(result.placeId);
                    setState(() {
                      liVAddressController.text = result.description;
                      placeId = result.placeId;
                      streetNumber = placeDetails.streetNumber;
                      street = placeDetails.street;
                      city = placeDetails.city;
                      country = placeDetails.country;
                      zipCode = placeDetails.zipCode;
                      latitude = placeDetails.latitude;
                      longitude = placeDetails.longitude;
                    });
                  }
                },
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.place,
                    color: Colors.grey,
                  ),
                  hintText: 'Lieu de Livraison',
                  labelText: 'Rue, Immeuble, ...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                controller: liVAddressController),
            SizedBox(height: 20),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('champ requise');
                  }

                  return getValidationError(value);
                },
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.location_city,
                    color: Colors.grey,
                  ),
                  hintText: 'Description du lieu ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                controller: liVdescriptionTextEditingController),
            SizedBox(height: 20),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('champ requise');
                  }

                  return getValidationError(value);
                },
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.info,
                    color: Colors.grey,
                  ),
                  hintText: 'Information pour le courier',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                controller: liVinfoCourTextEditingController),
          ],
        ),
      )),
    );
  }

  Widget _ButtonColi() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Moi'),
                    leading: Radio<Choice>(
                      value: Choice.moi,
                      groupValue: itemData,
                      onChanged: (Choice value) {
                        setState(() {
                          itemData = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Quelqu\'un'),
                    leading: Radio<Choice>(
                      value: Choice.autre,
                      groupValue: itemData,
                      onChanged: (Choice value) {
                        setState(() {
                          itemData = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _societePerson(_character, itemData) {
    if (_character == Singing.Entreprise && itemData == Choice.autre) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of('champ requise');
                }

                return getValidationError(value);
              },
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.location_city,
                  color: Colors.grey,
                ),
                hintText: 'Societe',
                labelText: 'Societe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              controller: societeTextEditingController),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _ButtonPerson(item) {
    if (item == Choice.autre) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
            child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('particulier'),
              leading: Radio<Singing>(
                value: Singing.particulier,
                groupValue: character,
                onChanged: (Singing value) {
                  setState(() {
                    character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Entreprise'),
              leading: Radio<Singing>(
                value: Singing.Entreprise,
                groupValue: character,
                onChanged: (Singing value) {
                  setState(() {
                    character = value;
                  });
                },
              ),
            ),
          ],
        )),
      );
    } else {
      return Container();
    }
  }

  String getValidationError(String field) {
    if (validationError == null || validationError[field] == null) {
      return null;
    }

    return validationError[field][0];
  }
}
