import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
//import 'package:mycar/Datahandler/appData.dart';
import 'package:mycar/constance/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mycar/modules/auth/login_screen.dart';
import 'package:provider/provider.dart';

import 'Language/appLocalizations.dart';
import 'constance/constance.dart';
import 'constance/themes.dart';
import 'package:mycar/constance/global.dart' as globals;
import 'modules/auth/register.dart';
import 'modules/home/home_screen.dart';
import 'modules/splash/SplashScreen.dart';
import 'modules/splash/nice_introduction_screen.dart';
import 'services/auth.service.dart';
import 'services/delivery_service.dart';
import 'stepper/stepperPage.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) => runApp(new MyApp()));
// }
Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("config");
  print("api_base_url: ${GlobalConfiguration().get('CallApi')}");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(new MyApp()));
}

class MyApp extends StatefulWidget {
  static changeTheme(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeTheme();
  }

  static setCustomeLanguage(BuildContext context, String languageCode) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLanguage(languageCode);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = new UniqueKey();

  var user;
  void changeTheme() {
    this.setState(() {
      var globals;
      globals.isLight = !globals.isLight;
    });
  }

  String locale = "fr";

  setLanguage(String languageCode) {
    setState(() {
      locale = languageCode;

      var constance = locale;
      //constance.locale = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    constance = locale;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          globals.isLight ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: CoustomTheme.getThemeData().cardColor,
      systemNavigationBarDividerColor:
          CoustomTheme.getThemeData().disabledColor,
      systemNavigationBarIconBrightness:
          globals.isLight ? Brightness.dark : Brightness.light,
    ));
    return MultiProvider(

        // Please make sure your Provider is mentioned here

        providers: [
          Provider<AuthService>(create: (_) => AuthService()),
          Provider<DeliveryService>(create: (_) => DeliveryService()),
          //ChangeNotifierProvider(create: (_) => DeliveryService(user, key)),
        ],
        child: Container(
          key: key,
          color: CoustomTheme.getThemeData().backgroundColor,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CoustomTheme.getThemeData().backgroundColor,
                  CoustomTheme.getThemeData().backgroundColor,
                  CoustomTheme.getThemeData().backgroundColor.withOpacity(0.8),
                  CoustomTheme.getThemeData().backgroundColor.withOpacity(0.7)
                ],
              ),
            ),
            child: MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en'), // English
                const Locale('fr'), // French
                //const Locale('ar'), // Arabic
              ],
              debugShowCheckedModeBanner: false,
              title: AppLocalizations.of('Shexpi_Client'),
              routes: routes,
              theme: CoustomTheme.getThemeData(),
              // builder: (BuildContext context, Widget child) {
              // return Directionality(
              //   textDirection: TextDirection.ltr,
              //   child: Builder(
              //     builder: (BuildContext context) {
              //       return MediaQuery(
              //         data: MediaQuery.of(context).copyWith(
              //           textScaleFactor: 1.0,
              //         ),
              //         child: child,
              //       );
              //     },
              //   ),
              // );
              //},
            ),
          ),
        ));
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.NICE_INTRODUCTION: (BuildContext context) =>
        NiceIntroductionScreen(),
    Routes.HOME: (BuildContext context) => HomeScreen(),
    Routes.LOGIN: (BuildContext context) => LoginScreen(),
    Routes.REGISTER: (BuildContext context) => RegisterScreen(),
    Routes.STEPPER: (BuildContext context) => FlutterStepperPage(),
  };
}
