import 'package:mycar/constance/global.dart' as globals;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycar/Language/appLocalizations.dart';
import 'package:mycar/modules/home/search.dart';
import 'package:mycar/services/auth.service.dart';
import 'package:mycar/services/placeService.dart';
import 'package:mycar/stepper/paymentMethod.dart';
import 'package:mycar/utilis/error/show_error.dart';
import 'package:mycar/utilis/http/http_exception.dart';
import 'package:provider/provider.dart';

class Personnal extends StatefulWidget {
  const Personnal({Key key}) : super(key: key);

  @override
  PersonnalState createState() => PersonnalState();
}

enum SingingCharacter { particulier, Entreprise }
enum Choix { moi, autre }

class PersonnalState extends State<Personnal> {
  static final formKey = GlobalKey<FormState>();

  var nameTextEditingController = TextEditingController();
  var surnameTextEditingController = TextEditingController();

  var villeTextEditingController = TextEditingController();
  var descriptionTextEditingController = TextEditingController();
  var codePostalTextEditingController = TextEditingController();
  var societeTextEditingController = TextEditingController();
  var infoCourTextEditingController = TextEditingController();

  var emailTextEditingController = TextEditingController();
  var ramassageAddressController = TextEditingController();

  var phoneTextEditingController = TextEditingController();

  var passwordTextEditingController = TextEditingController();
  var confirmPasswordTextEditingController = TextEditingController();
  var isLoading = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    passwordTextEditingController = TextEditingController();
    confirmPasswordTextEditingController = TextEditingController();
    ramassageAddressController = TextEditingController();
    emailTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    surnameTextEditingController = TextEditingController();
    phoneTextEditingController = TextEditingController();
    infoCourTextEditingController = TextEditingController();
    descriptionTextEditingController = TextEditingController();
  }

  final nameFocusNode = FocusNode();
  final surnameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final ramassageAddressFocusNode = FocusNode();
  final societeFocusNode = FocusNode();
  final codePostalFocusNode = FocusNode();
  final paysFocusNode = FocusNode();
  final villeFocusNode = FocusNode();
  final secteurFocusNode = FocusNode();

  @override
  void dispose() {
    nameFocusNode.dispose();
    surnameFocusNode.dispose();
    villeFocusNode.dispose();
    paysFocusNode.dispose();
    secteurFocusNode.dispose();
    societeFocusNode.dispose();
    emailFocusNode.dispose();
    ramassageAddressController.dispose();
    phoneFocusNode.dispose();
    codePostalFocusNode.dispose();
    super.dispose();
  }

  var validationError;
  GoogleMapController mapController;
  String streetNumber = '';
  String street = '';
  String placeId = '';
  double latitude;
  double longitude;
  String city = '';
  String country = '';
  String zipCode = '';

  SingingCharacter _character = SingingCharacter.particulier;
  Choix item = Choix.moi;

  @override
  Widget build(BuildContext context) {
    globals.locale = Localizations.localeOf(context);
    final authService = Provider.of<AuthService>(context);
    if (authService.authUser != null) {
      emailTextEditingController =
          TextEditingController(text: authService.authUser.email);
      nameTextEditingController =
          TextEditingController(text: authService.authUser.name);
      surnameTextEditingController =
          TextEditingController(text: authService.authUser.surname);
      phoneTextEditingController =
          TextEditingController(text: authService.authUser.phone);
      infoCourTextEditingController = TextEditingController();
      descriptionTextEditingController = TextEditingController();
    }
    return Material(
      child: Center(
        child: Form(
          key: formKey,
          //autovalidate: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  "Retrait du colis",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0), child: _ButtonColis()),
              _ButtonPersonnal(item),
              _societePersonnal(_character, item),
              TextFormField(
                maxLines: 1,
                controller: surnameTextEditingController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  hintText: 'Prenom',
                  labelText: 'Votre Prenom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('champ requise');
                  }

                  return getValidationError(value);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  hintText: 'Nom',
                  labelText: 'Nom de famille ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('champ requise');
                  }

                  return getValidationError(value);
                },
                controller: nameTextEditingController,
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (!value.contains('@')) {
                    return AppLocalizations.of(' email invalide');
                  }
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('champs requis');
                  }
                  return getValidationError(value);
                },
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  hintText: 'Email',
                  labelText: 'Address electronique ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                controller: emailTextEditingController,
              ),
              SizedBox(height: 20),
              TextFormField(
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
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                    hintText: 'Telephone',
                    labelText: 'Votre Numero de Telphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  controller: phoneTextEditingController),
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
                controller: ramassageAddressController,
                //readOnly: true,
                // focusNode: ramassageAddressFocusNode,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(phoneFocusNode);
                // },
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
                    ShowError.show(placeDetails.toString());
                    setState(() {
                      ramassageAddressController.text = result.description;
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
                  hintText: 'Lieu de ramassage',
                  labelText: 'address complete',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
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
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.location_city,
                      color: Colors.grey,
                    ),
                    hintText: 'Description du lieu ',
                    labelText: 'Rue, Immeuble, .... ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  controller: descriptionTextEditingController),
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
                    labelText: 'Informations additionnelles',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  controller: infoCourTextEditingController),
              _passAndpassConfirm(authService.authUser),
            ],
          ),
        ),
      ),
    );
  }

  String getValidationError(String field) {
    if (validationError == null || validationError[field] == null) {
      return null;
    }

    return validationError[field][0];
  }

  Widget _ButtonPersonnal(item) {
    if (item == Choix.autre) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
            child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('particulier'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.particulier,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Entreprise'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.Entreprise,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
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

  Widget _ButtonColis() {
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
                    leading: Radio<Choix>(
                      value: Choix.moi,
                      groupValue: item,
                      onChanged: (Choix value) {
                        setState(() {
                          item = value;
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
                    leading: Radio<Choix>(
                      value: Choix.autre,
                      groupValue: item,
                      onChanged: (Choix value) {
                        setState(() {
                          item = value;
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

  Widget _societePersonnal(_character, item) {
    if (_character == SingingCharacter.Entreprise && item == Choix.autre) {
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

  Widget _passAndpassConfirm(user) {
    if (user == null) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
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
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.grey,
                      ),
                      hintText: 'mot de passe',
                      labelText: 'mot de passe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    controller: passwordTextEditingController),
              ),
            ),
            Padding(
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
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.grey,
                      ),
                      hintText: 'confirme mot de passe',
                      labelText: 'confirme mot de passe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    controller: confirmPasswordTextEditingController),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Future<bool> register(GlobalKey<FormState> formKey) async {
    final isValid = formKey.currentState.validate();

    if (!isValid) {
      return null;
    }

    bool isSave = false;
    formKey.currentState.save();
    var addressValue = <String, dynamic>{
      'address': ramassageAddressController.text,
      'address_id': placeId,
      'city': city,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'type': 'personal',
    };
    ShowError.show(addressValue.toString());
    final params = <String, dynamic>{
      'address': addressValue,
      'name': nameTextEditingController.text,
      'surname': surnameTextEditingController.text,
      'phone': phoneTextEditingController.text.isNotEmpty
          ? '$countryCode${phoneTextEditingController.text}'
          : '',
      'email': emailTextEditingController.text,
      'password': confirmPasswordTextEditingController.text,
      'dial_code':
          phoneTextEditingController.text.isNotEmpty ? countryCode ?? '' : '',
      'accept_terms': 'true',
      'is_company': 'false',
    };
    ShowError.show(params.toString());
    try {
      await Provider.of<AuthService>(context, listen: false).register(params);

      setState(() {
        isLoading = false;
      });
      isSave = true;
      // Navigator.of(context).pushReplacementNamed(Routes.MAINSCREEN);
    } on HttpException catch (error) {
      if (error.type == ExceptionType.ValidationException) {
        setState(() {
          validationError = error.error;
          ShowError.show(validationError);
        });

        formKey.currentState.validate();
        isSave = false;
      }
    } catch (e) {
      print(e);
      isSave = false;
    }
    return isSave;
  }
}
