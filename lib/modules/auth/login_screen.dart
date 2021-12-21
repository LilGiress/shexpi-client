// import 'package:country_pickers/country.dart';
// import 'package:country_pickers/country_pickers.dart';

import 'package:flutter/material.dart';

import 'package:mycar/Language/appLocalizations.dart';
import 'package:mycar/constance/constance.dart';
import 'package:mycar/constance/routes.dart';
import 'package:mycar/constance/themes.dart';
import 'package:mycar/constance/global.dart' as globals;
import 'package:mycar/modules/home/home_screen.dart';
import 'package:mycar/modules/home/mainScreen.dart';
import 'package:mycar/modules/home/search.dart';
import 'package:mycar/modules/widgets/progressDialog.dart';
import 'package:mycar/modules/widgets/snackBar.dart';
import 'package:mycar/services/auth.service.dart';
import 'package:mycar/utilis/http/http_exception.dart';
import 'package:provider/provider.dart';

import 'forgotPassword.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool isDisable = false;
  var _isLoading = false;
  AnimationController animationController;
  // Country _selectedCountry = CountryPickerUtils.getCountryByIsoCode('US');
  bool isSignUp = true;
  bool _obscureText = true;
  bool agree = false;
  var validationError;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animationController..forward();

    if (Provider.of<AuthService>(context, listen: false).isAuth) {
      Navigator.pushNamed(context, Routes.HOME);
    }
  }

  String getValidationError(String field) {
    if (validationError == null || validationError[field] == null) {
      return null;
    }

    return validationError[field][0];
  }

  Future<void> _login() async {
    if (validationError != null) {
      setState(() {
        validationError = null;
      });
    }
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      setState(() {
        isDisable = true;
      });
      await Provider.of<AuthService>(context, listen: false).login(
          emailTextEditingController.text, passwordTextEditingController.text);

      setState(() {
        _isLoading = false;
      });

      // Navigator.of(context).pushReplacementNamed(Routes.HOME);
      Navigator.pushNamed(context, Routes.HOME);
    } on HttpException catch (error) {
      if (error.type == ExceptionType.ValidationException) {
        setState(() {
          isDisable = false;
        });
        print('Validation Exception');
        print(error.error);
        print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
        setState(() {
          validationError = error.error;
        });

        _formKey.currentState.validate();
      }
    } catch (e) {
      setState(() {
        isDisable = false;
      });

      print(e);
      ScaffoldMessenger.of(_formKey.currentContext).showSnackBar(
          SnackBar(content: Text('Mot de pass ou email incorrect')));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    globals.locale = Localizations.localeOf(context);
    return Provider<AuthService>(
      create: (_) => AuthService(),
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
                minWidth: MediaQuery.of(context).size.width),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
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
                                        transform: new Matrix4
                                                .translationValues(
                                            0.0,
                                            160 *
                                                    (1.0 -
                                                        (AlwaysStoppedAnimation(Tween(
                                                                        begin:
                                                                            0.4,
                                                                        end:
                                                                            1.0)
                                                                    .animate(CurvedAnimation(
                                                                        parent:
                                                                            animationController,
                                                                        curve: Curves
                                                                            .fastOutSlowIn)))
                                                                .value)
                                                            .value) -
                                                16,
                                            0.0),
                                        child: Image.asset(
                                          ConstanceData.buildingImageBack,
                                          color: HexColor("#4287f5"),
                                        ),
                                      ),
                                      Transform(
                                        transform: new Matrix4
                                                .translationValues(
                                            0.0,
                                            160 *
                                                (1.0 -
                                                    (AlwaysStoppedAnimation(Tween(
                                                                    begin: 0.8,
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
                                        bottom: (MediaQuery.of(context)
                                                .size
                                                .height /
                                            8),
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: Center(
                                          child: SizedBox(
                                            width: 120,
                                            height: 120,
                                            child: AnimatedBuilder(
                                              animation: animationController,
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                return Transform(
                                                  transform: new Matrix4
                                                          .translationValues(
                                                      0.0,
                                                      80 *
                                                          (1.0 -
                                                              (AlwaysStoppedAnimation(
                                                                Tween(
                                                                        begin:
                                                                            0.0,
                                                                        end:
                                                                            1.0)
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              36.0),
                                                    ),
                                                    elevation: 12,
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
                SingleChildScrollView(
                  padding: EdgeInsets.all(0.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: (MediaQuery.of(context).size.height / 2) -
                              (MediaQuery.of(context).size.height < 600
                                  ? 124
                                  : 86),
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
                                                      'Se connecter'),
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
                                    // Expanded(
                                    //   child: InkWell(
                                    //     focusColor: Colors.transparent,
                                    //     highlightColor: Colors.transparent,
                                    //     splashColor: Theme.of(context)
                                    //         .primaryColor
                                    //         .withOpacity(0.2),
                                    //     onTap: () {
                                    //       setState(() {
                                    //         isSignUp = false;
                                    //       });
                                    //     },
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(16.0),
                                    //       child: Column(
                                    //         mainAxisSize: MainAxisSize.min,
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.center,
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.center,
                                    //         children: <Widget>[
                                    //           Padding(
                                    //             padding: const EdgeInsets.all(4.0),
                                    //             child: Text(
                                    //               AppLocalizations.of('Se connecter'),
                                    //               style: Theme.of(context)
                                    //                   .textTheme
                                    //                   .headline6
                                    //                   .copyWith(
                                    //                     fontWeight: FontWeight.bold,
                                    //                     color: !isSignUp
                                    //                         ? Theme.of(context)
                                    //                             .textTheme
                                    //                             .headline6
                                    //                             .color
                                    //                         : Theme.of(context)
                                    //                             .disabledColor,
                                    //                   ),
                                    //             ),
                                    //           ),
                                    //           !isSignUp
                                    //               ? Padding(
                                    //                   padding:
                                    //                       const EdgeInsets.all(0.0),
                                    //                   child: Card(
                                    //                     elevation: 0,
                                    //                     color: Theme.of(context)
                                    //                         .primaryColor,
                                    //                     child: SizedBox(
                                    //                       height: 6,
                                    //                       width: 48,
                                    //                     ),
                                    //                   ),
                                    //                 )
                                    //               : SizedBox(),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
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
                                        _emailUI(),
                                        _passwordUI(),
                                        _loginTextUI(),
                                        _getSignUpButtonUI(),
                                      ],
                                    ),
                                  ),
                                  secondChild: IgnorePointer(
                                    ignoring: isSignUp,
                                    child: Column(
                                      children: <Widget>[
                                        // _loginTextUI(),
                                        // _passwordUI(),
                                        // // _countryView(),
                                        // _getSignUpButtonUI(),
                                        // _loginTextUI()
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
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(),
                      ),
                      // _facebookUI(),
                      //_checkBox(),
                      _creeCompteUI(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _facebookUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 24, right: 24, bottom: 0, top: 0),
  //     child: Container(
  //       height: 40,
  //       decoration: BoxDecoration(
  //         color: HexColor("#4267B2"),
  //         //borderRadius: BorderRadius.all(Radius.circular(24.0)),
  //         // boxShadow: <BoxShadow>[
  //         //   BoxShadow(
  //         //     color: Theme.of(context).dividerColor,
  //         //     blurRadius: 8,
  //         //     offset: Offset(4, 4),
  //         //   ),
  //         // ],
  //       ),
  //       child: Material(
  //         color: Colors.transparent,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             // Icon(
  //             //   FontAwesomeIcons.key,
  //             //   color: Colors.white,
  //             // ),
  //             SizedBox(
  //               width: 8,
  //             ),
  //             Text(
  //               AppLocalizations.of('Mot de passe oublié'),
  //               style: Theme.of(context).textTheme.subtitle1.copyWith(
  //                   color: Colors.white, fontWeight: FontWeight.bold),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _emailUI() {
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
            height: 48,
            child: Center(
              child: TextFormField(
                controller: emailTextEditingController,
                maxLines: 1,
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "name@example.com",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
                validator: (value) {
                  if (!value.contains('@')) {
                    return AppLocalizations.of(' email invalide');
                  }
                  if (value.isEmpty) {
                    return AppLocalizations.of('champs requis');
                  }
                  return getValidationError(value);
                },
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
            height: 48,
            child: Center(
              child: TextFormField(
                controller: passwordTextEditingController,
                maxLines: 1,
                onChanged: (String txt) {},
                cursorColor: Colors.black,
                obscureText: _obscureText,
                decoration: new InputDecoration(
                  errorText: null,
                  border: InputBorder.none,
                  hintText: "password",
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of('mot de passe invalide');
                  }

                  if (value.length < 6) {
                    return AppLocalizations.of('Doit être plus de 6 lettres');
                  }
                  return getValidationError(value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginTextUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 16, top: 10, bottom: 15),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassword()),
          );
        },
        child: Text(
          AppLocalizations.of('Mot de passe oublié ?'),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
        ),
      ),
    );
  }

  Widget _creeCompteUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 16, top: 15, bottom: 15),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterScreen()),
          );
        },
        child: Text(
          AppLocalizations.of('Créer un compte'),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  // Widget _countryView() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Theme.of(context).backgroundColor,
  //         borderRadius: BorderRadius.all(Radius.circular(38)),
  //         border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
  //       ),
  //       child: Row(
  //         children: <Widget>[
  //           SizedBox(
  //             width: 80,
  //             height: 60,
  //             child: CountryCodePicker(
  //               onChanged: (e) {
  //                 print(e.toLongString());
  //                 print(e.name);
  //                 print(e.code);
  //                 print(e.dialCode);
  //                 setState(() {
  //                   countryCode = e.dialCode;
  //                 });
  //               },
  //               initialSelection: 'भारत',
  //               showFlagMain: true,
  //               showFlag: true,
  //               favorite: ['+91','भारत'],
  //             ),
  //           ),
  //           Container(
  //             color: Theme.of(context).dividerColor,
  //             height: 32,
  //             width: 1,
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.only(left: 0, right: 16),
  //               child: Container(
  //                 height: 48,
  //                 child: TextField(
  //                   maxLines: 1,
  //                   onChanged: (String txt) {

  //                     phoneNumber = txt;
  //                   },
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                   ),
  //                   cursorColor: Theme.of(context).primaryColor,
  //                   decoration: new InputDecoration(
  //                     errorText: null,
  //                     border: InputBorder.none,
  //                     hintText: AppLocalizations.of(" Phone Number"),
  //                     hintStyle:
  //                         TextStyle(color: Theme.of(context).disabledColor),
  //                   ),
  //                   keyboardType: TextInputType.phone,
  //                   inputFormatters: <TextInputFormatter>[],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
            //borderRadius: BorderRadius.all(Radius.circular(24.0)),
            //highlightColor: Colors.transparent,
            onPressed: () {
              isDisable ? () => () {} : _login();
            },

            child: Center(
              child: Text(
                AppLocalizations.of(
                    isDisable ? 'Connexion en cours..' : 'Se connecter'),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // String getCountryString(String str) {
  //   var newString = '';
  //   var isFirstdot = false;
  //   for (var i = 0; i < str.length; i++) {
  //     if (isFirstdot == false) {
  //       if (str[i] != ',') {
  //         newString = newString + str[i];
  //       } else {
  //         isFirstdot = true;
  //       }
  //     }
  //   }
  //   return newString;
  // }

}
