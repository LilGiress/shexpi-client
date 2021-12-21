import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mycar/Language/appLocalizations.dart';
import 'package:mycar/constance/constance.dart';
import 'package:mycar/constance/countries.dart';
import 'package:mycar/constance/routes.dart';
import 'package:mycar/constance/themes.dart';
import 'package:mycar/constance/global.dart' as globals;
import 'package:mycar/modules/home/search.dart';
import 'package:mycar/services/auth.service.dart';
import 'package:mycar/services/placeService.dart';
import 'package:mycar/utilis/http/http_exception.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  var nameTextEditingController = TextEditingController();
  var surnameTextEditingController = TextEditingController();
  var villeTextEditingController = TextEditingController();
  var paysTextEditingController = TextEditingController();
  var codePostalTextEditingController = TextEditingController();
  var secteurTextEditingController = TextEditingController();
  var societeTextEditingController = TextEditingController();

  var emailTextEditingController = TextEditingController();
  var startAddressController = TextEditingController();

  var phoneTextEditingController = TextEditingController();

  var passwordTextEditingController = TextEditingController();
  var passwordConfirmationTextEditingController = TextEditingController();
  AnimationController animationController;
  // Country _selectedCountry = CountryPickerUtils.getCountryByIsoCode('US');
  bool isSignUp = true;
  bool isCompany = false;
  bool _obscureText = true;
  String pays;
  String countryCode = "+237";
  bool agree = false;
  var _currentSelectedValue;
  var _currentSelectedValue1;
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
  //var _dialCode = '+237';
  var isLoading = false;

  // _RegisterScreenState(this.res);
  String getValidationError(String field) {
    if (validationError == null || validationError[field] == null) {
      return null;
    }

    return validationError[field][0];
  }

  final nameFocusNode = FocusNode();
  final surnameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final passwordConfirmationFocusNode = FocusNode();
  final startAddressFocusNode = FocusNode();
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
    startAddressController.dispose();
    phoneFocusNode.dispose();
    codePostalFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animationController..forward();
  }

  @override
  Widget build(BuildContext context) {
    globals.locale = Localizations.localeOf(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        //resizeToAvoidBottomInset: false,

        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: SizedBox(
                  height: 700,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ClipRect(
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            child: AnimatedBuilder(
                              animation: animationController,
                              builder: (BuildContext context, Widget child) {
                                return Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    Transform(
                                      transform: new Matrix4.translationValues(
                                          0.0,
                                          100 *
                                                  (1.0 -
                                                      (AlwaysStoppedAnimation(Tween(
                                                                      begin:
                                                                          0.1,
                                                                      end: 1.0)
                                                                  .animate(CurvedAnimation(
                                                                      parent:
                                                                          animationController,
                                                                      curve: Curves
                                                                          .fastOutSlowIn)))
                                                              .value)
                                                          .value) -
                                              17,
                                          0.0),
                                      child: Image.asset(
                                        ConstanceData.buildingImageBack,
                                        color: HexColor("#4287f5"),
                                      ),
                                    ),
                                    Transform(
                                      transform: new Matrix4.translationValues(
                                          0.0,
                                          160 *
                                              (1.0 -
                                                  (AlwaysStoppedAnimation(Tween(
                                                                  begin: 0.4,
                                                                  end: 1.0)
                                                              .animate(CurvedAnimation(
                                                                  parent:
                                                                      animationController,
                                                                  curve: Curves
                                                                      .fastOutSlowIn)))
                                                          .value)
                                                      .value),
                                          0.0),
                                      child: Image.asset(
                                        ConstanceData.buildingImage,
                                        color: HexColor("#4287f5"),
                                      ),
                                    ),
                                    Positioned(
                                      bottom:
                                          (MediaQuery.of(context).size.height /
                                              4),
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: SizedBox(
                                          width: 100,
                                          height: 70,
                                          child: AnimatedBuilder(
                                            animation: animationController,
                                            builder: (BuildContext context,
                                                Widget child) {
                                              return Transform(
                                                transform: new Matrix4
                                                        .translationValues(
                                                    0.0,
                                                    70 *
                                                        (1.0 -
                                                            (AlwaysStoppedAnimation(
                                                              Tween(
                                                                      begin:
                                                                          0.0,
                                                                      end: 1.0)
                                                                  .animate(
                                                                CurvedAnimation(
                                                                  parent:
                                                                      animationController,
                                                                  curve: Curves
                                                                      .fastOutSlowIn,
                                                                ),
                                                              ),
                                                            ).value)
                                                                .value),
                                                    0.0),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            36.0),
                                                  ),
                                                  elevation: 10,
                                                  child: Image.asset(
                                                      ConstanceData.appIcon),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 150,),
              // Container(
              //   child: SizedBox(
              //     height: (MediaQuery.of(context).size.height / 2) -
              //         (MediaQuery.of(context).size.height < 160 ? 124 : 84),
              //   ),
              // ),
              Container(
                height: 800,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          margin: EdgeInsets.all(0),
                          elevation: 8,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      splashColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.2),
                                      onTap: () {
                                        setState(() {
                                          isSignUp = true;
                                          isCompany = false;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                AppLocalizations.of(
                                                    'Particulier'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: isSignUp
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .color
                                                          : Theme.of(context)
                                                              .disabledColor,
                                                    ),
                                              ),
                                            ),
                                            isSignUp
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Card(
                                                      elevation: 0,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      child: SizedBox(
                                                        height: 6,
                                                        width: 40,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      splashColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.2),
                                      onTap: () {
                                        setState(() {
                                          isSignUp = false;
                                          isCompany = true;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                AppLocalizations.of(
                                                    'Entreprise'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: !isSignUp
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .headline6
                                                              .color
                                                          : Theme.of(context)
                                                              .disabledColor,
                                                    ),
                                              ),
                                            ),
                                            !isSignUp
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Card(
                                                      elevation: 0,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      child: SizedBox(
                                                        height: 6,
                                                        width: 48,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 1,
                              ),
                              AnimatedCrossFade(
                                alignment: Alignment.topCenter,
                                reverseDuration: Duration(milliseconds: 420),
                                duration: Duration(milliseconds: 420),
                                crossFadeState: !isSignUp
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                firstCurve: Curves.fastOutSlowIn,
                                secondCurve: Curves.fastOutSlowIn,
                                sizeCurve: Curves.fastOutSlowIn,
                                firstChild: IgnorePointer(
                                  ignoring: !isSignUp,
                                  child: Column(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          _nameUI(),
                                          _surnameUI(),
                                          _emailUI(),
                                          _passwordUI(),
                                          _password2UI(),
                                          _countryView(),
                                          _villeUI(),
                                          _codePostalUI(),
                                          _addressUI(),
                                          _pays(),
                                          //_facebookUI(),

                                          _checkBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                secondChild: IgnorePointer(
                                  ignoring: isSignUp,
                                  child: Column(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          _societeUI(),
                                          _secteurActivite(),
                                          _nameUI(),
                                          _surnameUI(),
                                          _emailUI(),
                                          _passwordUI(),
                                          _password2UI(),
                                          _countryView(),
                                          _villeUI(),
                                          _codePostalUI(),
                                          _addressUI(),
                                          _pays(),
                                          // _facebookUI(),

                                          _checkBox(),

                                          // _getSignUpButtonUI(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _facebookUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 0, top: 0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: HexColor("#4267B2"),
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).dividerColor,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.key,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of('Mot de passe oublié'),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailUI() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 40,
            child: Center(
              child: TextFormField(
                validator: (value) {
                  if (!value.contains('@')) {
                    return AppLocalizations.of(' email invalide');
                  }
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('champs requis');
                  }
                  return getValidationError(value);
                },
                controller: emailTextEditingController,
                focusNode: emailFocusNode,
                maxLines: 1,
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "john@example.com",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 40,
            child: Center(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('ne doit pas etre vide');
                  }
                  return getValidationError(value);
                },
                controller: nameTextEditingController,
                focusNode: nameFocusNode,
                maxLines: 1,
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "Nom",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _surnameUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 40,
            child: Center(
              child: TextFormField(
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(surnameFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of('Required field');
                  }

                  return getValidationError('surname');
                },
                controller: surnameTextEditingController,
                focusNode: surnameFocusNode,
                maxLines: 1,
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "Prenom",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _societeUI() {
    if (isCompany) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(38)),
            border:
                Border.all(color: Theme.of(context).dividerColor, width: 0.6),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              height: 40,
              child: Center(
                child: TextFormField(
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(societeFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of('Required field');
                    }

                    return getValidationError(value);
                  },
                  controller: societeTextEditingController,
                  focusNode: societeFocusNode,
                  maxLines: 1,
                  onChanged: (String txt) {},
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                    errorText: null,
                    border: InputBorder.none,
                    hintText: "Societe",
                    hintStyle:
                        TextStyle(color: Theme.of(context).disabledColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _codePostalUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 40,
            child: Center(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('Required field');
                  }
                  return getValidationError(value);
                },
                controller: codePostalTextEditingController,
                focusNode: codePostalFocusNode,
                maxLines: 1,
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "Code Postal",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _villeUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 40,
            child: Center(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('Required field');
                  }

                  return getValidationError(value);
                },
                controller: villeTextEditingController,
                focusNode: villeFocusNode,
                maxLines: 1,
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "Ville",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 40,
            child: Center(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('mot de passe invalide');
                  }

                  if (value.length < 6) {
                    return AppLocalizations.of('Doit être plus de 6 lettres');
                  }
                  return getValidationError(value);
                },
                controller: passwordTextEditingController,
                focusNode: passwordFocusNode,
                maxLines: 1,
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                obscureText: _obscureText,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "Entrée un mot de passe",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _password2UI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 40,
            child: Center(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of('mot de passe invalide');
                  }

                  if (value != passwordConfirmationTextEditingController.text) {
                    return AppLocalizations.of('Not Match');
                  }
                  return getValidationError(value);
                },
                controller: passwordConfirmationTextEditingController,
                focusNode: passwordConfirmationFocusNode,
                maxLines: 1,
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                obscureText: _obscureText,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "confirmer mot de passe",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addressUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 40,
            child: Center(
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of('Required field');
                  }
                  if (value.length < 2) {
                    return AppLocalizations.of('Should be more than 2 letters');
                  }
                  return null;
                },
                controller: startAddressController,
                //readOnly: true,
                focusNode: startAddressFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(phoneFocusNode);
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
                      startAddressController.text = result.description;
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
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  errorText: null,
                  icon: Icon(Icons.my_location),
                  border: InputBorder.none,
                  hintText: ' Entrez votre address',
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _loginTextUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 24, right: 16, top: 300, bottom: 30),
  //     child: Container(
  //       alignment: Alignment.centerLeft,
  //       child: Text(
  //         AppLocalizations.of('Login with your phone number'),
  //         style: Theme.of(context).textTheme.bodyText2.copyWith(
  //               fontWeight: FontWeight.bold,
  //             ),
  //       ),
  //     ),
  //   );
  // }

  Widget _countryView() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
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
              width: 1,
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
                      hintText: AppLocalizations.of("Numero de téléphone "),
                      hintStyle:
                          TextStyle(color: Theme.of(context).disabledColor),
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
    );
  }

  Widget _checkBox() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              'J\'ai lu et j\'accepte les termes et conditions',
              overflow: TextOverflow.fade,
              maxLines: 2,
            ),
            value: agree,
            onChanged: (value) {
              setState(() {
                agree = value ?? false;
              });
            },
          ),
          _getSignUpButtonUI(),
        ],
      ),
    );
  }

  Widget _getSignUpButtonUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
        child: Material(
          color: Colors.transparent,
          child: ElevatedButton(
            // borderRadius: BorderRadius.all(Radius.circular(24.0)),
            // highlightColor: Colors.transparent,
            onPressed: _register,
            child: Text(
              isSignUp
                  ? AppLocalizations.of('Se connecter')
                  : AppLocalizations.of('Next'),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pays() {
    var _ocurrencies = countries;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: DropdownButtonFormField<String>(
            hint: Text(
              'Sectionnez votre pays',
            ),
            isExpanded: true,
            value: _currentSelectedValue1,
            validator: (value) => value == null ? 'champ obligatoire' : null,
            isDense: true,
            onChanged: (String newValue) {
              setState(() {
                _currentSelectedValue1 = newValue;
              });
            },
            items: _ocurrencies.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _secteurActivite() {
    if (isCompany) {
      List<Map<String, dynamic>> _currencies = [];

      _currencies = [
        {"key": "catering", "label": "Restauration"},
        {
          "key": "e_commerce",
          "label": "Vente en ligne",
        },
        {
          "key": "others",
          "label": "others",
        }
        // "Vente en ligne",
        // "Restauration",
        // "catering",
        //  "e_commerce",
        //  " others"
      ];

      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(38)),
            border:
                Border.all(color: Theme.of(context).dividerColor, width: 0.6),
          ),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: _currentSelectedValue,
            validator: (value) => value == null ? 'field required' : null,
            hint: Text(
              'Secteur d\'activité',
            ),
            onChanged: (String newValue) {
              setState(() {
                _currentSelectedValue = newValue;
              });
            },
            items: _currencies.map((dynamic value) {
              return DropdownMenuItem<String>(
                  value: value['key'],
                  child: Text(
                    value['label'],
                  ));
            }).toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  String getCountryString(String str) {
    var newString = '';
    var isFirstdot = false;
    for (var i = 0; i < str.length; i++) {
      if (isFirstdot == false) {
        if (str[i] != ',') {
          newString = newString + str[i];
        } else {
          isFirstdot = true;
        }
      }
    }
    return newString;
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(AppLocalizations.of('An error occurred')),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  Future<void> _register() async {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState.save();

    setState(() {
      isLoading = true;
    });

    var addressValue = <String, dynamic>{
      'address': startAddressController.text,
      'address_id': placeId,
      'city': city,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'type': 'personal',
    };
    var company = <String, dynamic>{
      "name": societeTextEditingController.text,
      "business_segment": _currentSelectedValue
    };

    final params = <String, dynamic>{
      'name': nameTextEditingController.text,
      'surname': surnameTextEditingController.text,
      'phone': surnameTextEditingController.text.isNotEmpty
          ? '$countryCode${phoneTextEditingController.text}'
          : '',
      'email': emailTextEditingController.text,
      'password': passwordTextEditingController.text,
      'dial_code':
          phoneTextEditingController.text.isNotEmpty ? countryCode ?? '' : '',
      'accept_terms': 'true',
      'address': addressValue,
      'is_company': isCompany,
    };
    if (isCompany) {
      params['company'] = company;
    }
    try {
      await Provider.of<AuthService>(context, listen: false).register(params);

      setState(() {
        isLoading = false;
      });

      Navigator.of(context).pushReplacementNamed(Routes.HOME);
    } on HttpException catch (error) {
      if (error.type == ExceptionType.ValidationException) {
        setState(() {
          validationError = error.error;
        });

        _formKey.currentState.validate();

        if (getValidationError('phone') != null) {
          _showErrorDialog(getValidationError('phone'));
        }
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }
}
