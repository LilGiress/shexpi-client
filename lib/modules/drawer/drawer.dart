// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycar/Language/appLocalizations.dart';
import 'package:mycar/constance/constance.dart';
import 'package:mycar/constance/routes.dart';
import 'package:mycar/models/user.dart';

import 'package:mycar/modules/history/history_Screen.dart';
import 'package:mycar/modules/home/home_screen.dart';
import 'package:mycar/modules/inviteFriends/inviteFriends_Screen.dart';
import 'package:mycar/modules/notification/notification_Screen.dart';
import 'package:mycar/modules/setting/setting_Screen.dart';
import 'package:mycar/modules/wallet/myWallet.dart';
import 'package:mycar/services/auth.service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  final String selectItemName;

  const AppDrawer({Key key, this.selectItemName}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final tokenKey = 'currentToken';
  String _token;
  DateTime _expiryDate;
  User _authUser;
  Timer _authTimer;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                height: 200,
              ),
              SizedBox(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: -150,
                      right: -10,
                      top: -800,
                      bottom: 80,
                      child: SizedBox(
                        height: 800,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(500),
                          ),
                          margin: EdgeInsets.all(0),
                          color: Colors.black.withOpacity(0.06),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -200,
                      right: 110,
                      top: -50,
                      bottom: -5,
                      child: SizedBox(
                        height: 400,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(500),
                          ),
                          margin: EdgeInsets.all(0),
                          color: Colors.black.withOpacity(0.06),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                        color: Theme.of(context).cardColor,
                        padding: EdgeInsets.all(2),
                        child: authService.authUser != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  ConstanceData.userImage,
                                  height: 80,
                                  width: 80,
                                ),
                              )
                            : Center(
                                child: Text(
                                "SHEXPI",
                              )),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      authService.authUser != null
                          ? authService.authUser.fullNameAbr
                          : '',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).backgroundColor,
                          ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    authService.authUser != null
                        ? Row(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of("Cash"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                            ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "2500",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Theme.of(context).disabledColor,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
          authService.authUser != null
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 26,
                          ),
                          Row(
                            children: <Widget>[
                              widget.selectItemName == 'Home'
                                  ? selectedData()
                                  : SizedBox(),
                              Icon(
                                Icons.home,
                                size: 28,
                                color: widget.selectItemName == 'Home'
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppLocalizations.of('Home'),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyWallet(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Row(
                                children: <Widget>[
                                  widget.selectItemName == 'MyWallet'
                                      ? selectedData()
                                      : SizedBox(),
                                  Icon(
                                    FontAwesomeIcons.wallet,
                                    size: 20,
                                    color: widget.selectItemName == 'MyWallet'
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.2),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of('Mon portefeuille'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Row(
                                children: <Widget>[
                                  widget.selectItemName == 'History'
                                      ? selectedData()
                                      : SizedBox(),
                                  Icon(
                                    FontAwesomeIcons.history,
                                    size: 20,
                                    color: widget.selectItemName == 'History'
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.2),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of('Historique'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Row(
                                children: <Widget>[
                                  widget.selectItemName == 'Notification'
                                      ? selectedData()
                                      : SizedBox(),
                                  Icon(
                                    FontAwesomeIcons.solidBell,
                                    size: 20,
                                    color:
                                        widget.selectItemName == 'Notification'
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .disabledColor
                                                .withOpacity(0.2),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of('Notification'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InviteFriendsScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Row(
                                children: <Widget>[
                                  widget.selectItemName == 'Invite'
                                      ? selectedData()
                                      : SizedBox(),
                                  Icon(
                                    FontAwesomeIcons.gifts,
                                    size: 18,
                                    color: widget.selectItemName == 'Invite'
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.2),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of('Inviter un(e) Ami(e)'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Row(
                                children: <Widget>[
                                  widget.selectItemName == 'Parametre'
                                      ? selectedData()
                                      : SizedBox(),
                                  Icon(
                                    FontAwesomeIcons.cog,
                                    size: 20,
                                    color: widget.selectItemName == 'Parametre'
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.2),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of('Parametre'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Provider.of<AuthService>(context, listen: false)
                                  .logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                // the new route
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomeScreen(),
                                ),

                                // this function should return true when we're done removing routes
                                // but because we want to remove all other screens, we make it
                                // always return false
                                (Route route) => false,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.signOutAlt,
                                    size: 20,
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of('Logout'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color,
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
                )
              : Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          widget.selectItemName == 'Home'
                              ? selectedData()
                              : SizedBox(),
                          Icon(
                            Icons.home,
                            size: 28,
                            color: widget.selectItemName == 'Home'
                                ? Theme.of(context).primaryColor
                                : Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.2),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            AppLocalizations.of('Home'),
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.LOGIN,
                              arguments: (Route<dynamic> route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.signInAlt,
                                size: 20,
                                color: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.2),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                AppLocalizations.of('Login'),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget selectedData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 28,
          width: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
