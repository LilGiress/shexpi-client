import 'dart:collection';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycar/services/delivery_service.dart';
import 'package:provider/provider.dart';

import 'package:mycar/Language/appLocalizations.dart';
import 'package:mycar/modules/home/search.dart';
import 'package:mycar/services/auth.service.dart';
import 'package:mycar/services/placeService.dart';
import 'package:mycar/utilis/error/show_error.dart';
import 'package:mycar/utilis/http/http_exception.dart';

import '../constance/global.dart' as globals;
import 'contact.dart';
import 'date_selector.dart';
import 'paymentMethod.dart';
import 'personnal.dart';
import 'planification.dart';
import 'recapDemande.dart';
import 'upload.dart';

class FlutterStepperPage extends StatefulWidget {
  final bool delivery;
  final int deliveryTime;
  final Future Function(BuildContext, int) onSave;
  final Future Function(BuildContext, bool) onDeliveryModeChange;
  final void Function(BuildContext context, dynamic error) onError;
  FlutterStepperPage({
    Key key,
    this.delivery,
    this.deliveryTime,
    this.onSave,
    this.onDeliveryModeChange,
    this.onError,
  }) : super(key: key);

  @override
  _FlutterStepperPageState createState() => _FlutterStepperPageState();
}

enum SingingCharacter { particulier, Entreprise }
enum Choix { moi, autre }
enum Singing { particulier, Entreprise }
enum Choice { moi, autre }
enum Character { isPossible, isTard }

class _FlutterStepperPageState extends State<FlutterStepperPage> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  String countryCode = "+237";
  var isLoading = false;
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
  var liVnameTextEditingController = TextEditingController();
  var liVsurnameTextEditingController = TextEditingController();
  var liVvilleTextEditingController = TextEditingController();
  var liVdescriptionTextEditingController = TextEditingController();
  var liVcodePostalTextEditingController = TextEditingController();
  var liVsocieteTextEditingController = TextEditingController();
  var liVinfoCourTextEditingController = TextEditingController();

  var liVemailTextEditingController = TextEditingController();
  var liVAddressController = TextEditingController();

  var liVphoneTextEditingController = TextEditingController();
  var payementphoneTextEditingController = TextEditingController();

  //var isLoading = false;
  bool _obscureText = true;
  var deliveryTime;
  // var deliveryHour;
  var _savedDeliveryTime;

  DeliveryDate _deliveryDate;
  DeliveryHour _deliveryHour;
  List<DeliveryDate> _deliveryDates = [];
  List<DeliveryHour> _deliveryHours = [];
  bool isPossible = true;
  bool isTard = false;

  void _initDeliveryTime(deliveryTime) {
    setState(() {
      _deliveryDates = DateSelector.getDeliveryDates(context);

      _deliveryDate = deliveryTime != null
          ? DateSelector.getDeliveryDate(context, deliveryTime)
          : _deliveryDates.first;

      _deliveryHours = _deliveryDate.hours;

      _deliveryHour = deliveryTime != null
          ? DateSelector.getDeliveryHour(context, deliveryTime)
          : _deliveryHours.first;

      deliveryTime = _deliveryHour.timestamp;
    });
  }

  void _changeDeliveryDate(deliveryDate) {
    setState(() {
      _deliveryDate = _deliveryDates.firstWhere(
          (element) => element.date == deliveryDate,
          orElse: () => null);

      _deliveryHours = _deliveryDate.hours;

      _deliveryHour = _deliveryHours.first;

      deliveryTime = _deliveryHour.timestamp;

      widget.onDeliveryModeChange(context, deliveryTime);
    });
  }

  void _changeDeliveryHour(deliveryTime) {
    setState(() {
      _deliveryHour = _deliveryHours.firstWhere(
          (element) => element.timestamp.toString() == deliveryTime,
          orElse: () => null);

      deliveryTime = _deliveryHour.timestamp;

      widget.onDeliveryModeChange(context, deliveryTime);
    });
  }

  @override
  void didChangeDependencies() {
    _initDeliveryTime(deliveryTime);
    if (deliveryTime != null) {}
    super.didChangeDependencies();
  }

  @override
  void initState() {
    deliveryTime = widget.deliveryTime;

    _savedDeliveryTime = widget.deliveryTime;
    passwordTextEditingController = TextEditingController();
    confirmPasswordTextEditingController = TextEditingController();
    ramassageAddressController = TextEditingController();
    emailTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    surnameTextEditingController = TextEditingController();
    phoneTextEditingController = TextEditingController();
    infoCourTextEditingController = TextEditingController();
    descriptionTextEditingController = TextEditingController();
    liVAddressController = TextEditingController();
    liVemailTextEditingController = TextEditingController();
    liVnameTextEditingController = TextEditingController();
    liVsurnameTextEditingController = TextEditingController();
    liVphoneTextEditingController = TextEditingController();
    liVinfoCourTextEditingController = TextEditingController();
    liVdescriptionTextEditingController = TextEditingController();
    super.initState();
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
  Singing character = Singing.particulier;
  Choice itemData = Choice.moi;
  Character Auto = Character.isPossible;
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
    var mapData = HashMap<String, String>();

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
    // mapData["planingJours"] =
    //     PlanificationRamassageState.deliveryHour.toString();
    // mapData["planingHeure"] =
    //     PlanificationRamassageState.deliveryTime.toString();

    List<Step> steps = [
      Step(
        title: Text(' '),
        content: Form(
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
        //content: Personnal(),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(' '),
        content: Form(
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
                      return AppLocalizations.of(
                          'Should be more than 2 letters');
                    }
                    return null;
                  },
                  onTap: () async {
                    // generate a new token here
                    final Suggestion result = await showSearch(
                      context: context,
                      delegate: AddressSearch(
                          hintText: AppLocalizations.of('Search')),
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
        ),
        //content: Contact(),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: Column(children: <Widget>[
          Center(
            child: Text(
              "Planification du ramassage du colis",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _ButtonColise(),
          _ButtonPersonnalite(Auto),
        ]),
        //content: PlanificationRamassage(),
        state: currentStep == 2 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text('  '),
        content: Column(
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
                        Text(liVAddressController.text,
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              )
            ]),
          ],
        ),
        //content: Recapitulatif(),
        state: currentStep == 3 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        //content: PaymentMethod(),
        content: Padding(
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
                              padding:
                                  const EdgeInsets.only(left: 0, right: 16),
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
                                  controller:
                                      payementphoneTextEditingController,
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
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
                                                          "postal_code":
                                                              "73301",
                                                          "phone": "+00000000",
                                                          "state": "Texas"
                                                        },
                                                      }
                                                    }
                                                  ],
                                                  note:
                                                      "Contact us for any questions on your order.",
                                                  onSuccess:
                                                      (Map params) async {
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
        state: currentStep == 4 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: Upload(mapData),
        state: StepState.complete,
        isActive: true,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Demande de Livraison'),
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                height: 900,
              ),
              child: Stepper(
                physics: ScrollPhysics(),
                elevation: 2.0,
                currentStep: this.currentStep,
                steps: steps,
                type: StepperType.horizontal,
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (currentStep < steps.length - 1) {
                      if (currentStep == 0 && formKey.currentState.validate()) {
                        if (authService.authUser == null) {
                          register(formKey)
                              .then((value) => {currentStep = currentStep + 1});
                        } else {}
                      } else if (currentStep == 1 &&
                          ContactState.formKey.currentState.validate()) {
                        currentStep = currentStep + 1;
                      } else if (currentStep != 0 && currentStep != 1) {
                        currentStep = currentStep + 1;
                      }
                    } else {
                      currentStep = 0;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep = currentStep - 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
              ),
            ),
          ),
        ],
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

  Widget _ButtonPersonnalite(Auto) {
    if (Auto == Character.isTard) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                DropdownButtonFormField(
                  isExpanded: true,
                  value: _deliveryDate.date,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20,
                  elevation: 16,
                  style: Theme.of(context).textTheme.subtitle1,
                  onChanged: _changeDeliveryDate,
                  items: _deliveryDates
                      .map<DropdownMenuItem<String>>((DeliveryDate date) {
                    return DropdownMenuItem<String>(
                      value: date.date,
                      child: Text(date.displayText),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                DropdownButtonFormField(
                  isExpanded: true,
                  value: _deliveryHour.timestamp.toString(),
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20,
                  elevation: 16,
                  style: Theme.of(context).textTheme.subtitle1,
                  onChanged: _changeDeliveryHour,
                  items: _deliveryHours
                      .map<DropdownMenuItem<String>>((DeliveryHour value) {
                    return DropdownMenuItem<String>(
                      value: value.timestamp.toString(),
                      child: Text(value.displayText),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _ButtonColise() {
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
                    title: const Text('Aussitôt que possible'),
                    leading: Radio<Character>(
                      value: Character.isPossible,
                      groupValue: Auto,
                      onChanged: (Character value) {
                        setState(() {
                          Auto = value;
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
                    title: const Text('Pour plus tard'),
                    leading: Radio<Character>(
                      value: Character.isTard,
                      groupValue: Auto,
                      onChanged: (Character value) {
                        setState(() {
                          Auto = value;
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

  Future<bool> store(GlobalKey<FormState> formKey) async {
    final isValid = formKey.currentState.validate();

    if (!isValid) {
      return null;
    }

    bool isSave = false;
    formKey.currentState.save();
    // var addressValue = <String, dynamic>{
    //   'address': ramassageAddressController.text,
    //   'address_id': placeId,
    //   'city': city,
    //   'country': country,
    //   'latitude': latitude,
    //   'longitude': longitude,
    //   'type': 'personal',
    // };

    final params = <String, dynamic>{
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
      'delivery_timezone': 0,
      'delivery_time': 0,
      'delivery_distance': 0,
      'delivery_fees': 0,
      'delivery_travel_time': 0,
      'currency': 0,
      'delivery_asap': 'true',
      'status': 'PENDING',
      'pickup_address': ramassageAddressController.text,
      'delivery_address': liVAddressController.text,
    };
    ShowError.show(params.toString());
    try {
      await Provider.of<DeliveryService>(context, listen: false).store(params);

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
