import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mycar/Language/appLocalizations.dart';
import 'package:mycar/constance/constance.dart';
import 'package:mycar/constance/routes.dart';
import 'package:mycar/constance/themes.dart';
import 'package:mycar/constance/global.dart' as globals;
import 'package:mycar/modules/drawer/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;

 
  final _doualaLatLong = LatLng(4.0300787, 9.7761342);
   
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
bool isSignUp = true;
  bool isSerchMode = false;
  bool isUp = true;
  BitmapDescriptor carMapBitmapDescriptor;
  BitmapDescriptor startMapBitmapDescriptor;
  BitmapDescriptor endMapBitmapDescriptor;
  BuildContext currentcontext;
  TextEditingController serachController = TextEditingController();

  ProsseType prosseType = ProsseType.dropOff;

  // int carOneIndex = 0, carTwoIndex = 0, carThreeIndex = 0, carFourIndex = 0, carFiveIndex = 0;
  // List<LatLng> carPointOne = [], carPointTwo = [], carPointThree = [], carPointFour = [], carPointFive = [], poliList = [];

  // void setMakerPinSize(BuildContext context) async {
  //   if (currentcontext == null) {
  //     currentcontext = context;
  //     final ImageConfiguration imagesStartConfiguration = createLocalImageConfiguration(currentcontext);
  //     carMapBitmapDescriptor = await BitmapDescriptor.fromAssetImage(imagesStartConfiguration, ConstanceData.mapCar);
  //     final ImageConfiguration startStartConfiguration = createLocalImageConfiguration(currentcontext);
  //     startMapBitmapDescriptor = await BitmapDescriptor.fromAssetImage(startStartConfiguration, ConstanceData.startmapPin);
  //     final ImageConfiguration endStartConfiguration = createLocalImageConfiguration(currentcontext);
  //     endMapBitmapDescriptor = await BitmapDescriptor.fromAssetImage(endStartConfiguration, ConstanceData.endmapPin);
  //   }
  // }

  // final _random = new math.Random();
  // int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    // serachController.text = AppLocalizations.of('105 William st, Chicago, US');
    // animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 480));
    // animationController..animateTo(1);
    super.initState();
   // _carPinInitState();
  }

  // void _carPinInitState() {
  //   carPointOne = ConstanceData.getCarOnePolyLineList();
  //   carPointTwo = ConstanceData.getCarTwoPolyLineList();
  //   carPointThree = ConstanceData.getCarThreePolyLineList();
  //   carPointFour = ConstanceData.getCarFourPolyLineList();
  //   poliList = ConstanceData.getRoutePolyLineList();
  //   Timer(Duration(milliseconds: next(1200, 4000)), carOnePin);
  //   Timer(Duration(milliseconds: next(1200, 4000)), carTwoPin);
  //   Timer(Duration(milliseconds: next(1200, 4000)), carThreePin);
  //   Timer(Duration(milliseconds: next(1200, 4000)), carFourPin);
  // }

  // Future carOnePin() async {
  //   if (carOneIndex + 1 < carPointOne.length) {
  //     carOneIndex += 1;
  //   } else {
  //     carOneIndex = 0;
  //   }
  //   if (mounted) setState(() {});
  //   Timer(Duration(milliseconds: next(1200, 4000)), carOnePin);
  // }

  // Future carTwoPin() async {
  //   if (carTwoIndex + 1 < carPointTwo.length) {
  //     carTwoIndex += 1;
  //   } else {
  //     carTwoIndex = 0;
  //   }
  //   if (mounted) setState(() {});
  //   Timer(Duration(milliseconds: next(1200, 4000)), carTwoPin);
  // }

  // Future carThreePin() async {
  //   if (carThreeIndex + 1 < carPointThree.length) {
  //     carThreeIndex += 1;
  //   } else {
  //     carThreeIndex = 0;
  //   }
  //   if (mounted) setState(() {});
  //   Timer(Duration(milliseconds: next(1200, 4000)), carThreePin);
  // }

  // Future carFourPin() async {
  //   if (carFourIndex + 1 < carPointFour.length) {
  //     carFourIndex += 1;
  //   } else {
  //     carFourIndex = 0;
  //   }
  //   if (mounted) setState(() {});
  //   Timer(Duration(milliseconds: next(1200, 4000)), carFourPin);
  // }

  // Map<MarkerId, Marker> getMarkerList(BuildContext context) {
  //   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //   if (carMapBitmapDescriptor != null) {
  //     for (var i = 0; i < 4; i++) {
  //       LatLng startPoint = i == 0
  //           ? carPointOne[carOneIndex]
  //           : i == 1
  //               ? carPointTwo[carTwoIndex]
  //               : i == 2
  //                   ? carPointThree[carThreeIndex]
  //                   : carPointFour[carFourIndex];
  //       LatLng lastPoint = i == 0
  //           ? carPointOne[carOneIndex - 1 == -1 ? carPointOne.length - 1 : carOneIndex - 1]
  //           : i == 1
  //               ? carPointTwo[carTwoIndex - 1 == -1 ? carPointTwo.length - 1 : carTwoIndex - 1]
  //               : i == 2
  //                   ? carPointThree[carThreeIndex - 1 == -1 ? carPointThree.length - 1 : carThreeIndex - 1]
  //                   : carPointFour[carFourIndex - 1 == -1 ? carPointFour.length - 1 : carFourIndex - 1];

  //       final MarkerId markerId2 = MarkerId('$i');
  //       final Marker marker2 = Marker(
  //           markerId: markerId2,
  //           position: startPoint,
  //           anchor: Offset(0.5, 0.5),
  //           icon: carMapBitmapDescriptor,
  //           rotation: ConstanceData.getCarAngle(startPoint, lastPoint));
  //       markers.addAll({markerId2: marker2});
  //     }
  //   }

  //   if (startMapBitmapDescriptor != null && endMapBitmapDescriptor != null && prosseType == ProsseType.requset) {
  //     final MarkerId markerId2 = MarkerId('start');
  //     final Marker marker2 = Marker(
  //       markerId: markerId2,
  //       position: poliList.first,
  //       anchor: Offset(0.5, 0.5),
  //       icon: startMapBitmapDescriptor,
  //     );
  //     markers.addAll({markerId2: marker2});

  //     final MarkerId markerId = MarkerId('end');
  //     final Marker marker = Marker(
  //       markerId: markerId,
  //       position: poliList.last,
  //       anchor: Offset(0.5, 1.0),
  //       icon: endMapBitmapDescriptor,
  //     );
  //     markers.addAll({markerId: marker});
  //   }

  //   return markers;
  // }

  // Map<PolylineId, Polyline> getPolilineData() {
  //   Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  //   if (poliList.length > 2 && prosseType == ProsseType.requset) {
  //     final PolylineId polylineId = PolylineId('123');
  //     final Polyline polyline = Polyline(
  //       polylineId: polylineId,
  //       color: HexColor(globals.primaryRiderColorString),
  //       consumeTapEvents: false,
  //       points: poliList,
  //       width: Platform.isAndroid ? 4 : 2,
  //       startCap: Cap.roundCap,
  //       endCap: Cap.roundCap,
  //     );
  //     _polylines.addAll({polylineId: polyline});
  //   }
  //   return _polylines;
  // }

 Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(4.0570796, 9.709335),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(currentLocation.latitude, currentLocation.longitude),
  //     tilt: 59.440717697143555,
  //     zoom: 16.151926040649414);

void _currentLocation() async {
   final GoogleMapController controller = await _controller.future;
   LocationData currentLocation;
   var location = new Location();
   try {
     currentLocation = await location.getLocation();
     } on Exception {
       currentLocation = null;
       }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 15.0,
      ),
    ));
  }


  @override
  Widget build(BuildContext context) {
    //setMakerPinSize(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75 < 400 ? MediaQuery.of(context).size.width * 0.72 : 350,
        child: Drawer(
          child: AppDrawer(
            selectItemName: 'Home',
            
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
               initialCameraPosition: _kGooglePlex,
              // initialCameraPosition: CameraPosition(
              //   target: _doualaLatLong,
              //   tilt: 30.0,
              //   zoom: 16,
              // ),
              myLocationEnabled: true,
               padding: EdgeInsets.only(top: 30.0,),
             
              mapType: MapType.normal,
             
            // markers: Set<Marker>.of(getMarkerList(context).values),
            // onCameraMove: (CameraPosition position) {},
            // polylines: Set<Polyline>.of(getPolilineData().values),
            // onCameraIdle: () {},
              compassEnabled: false,
              myLocationButtonEnabled: true,
             rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              
             buildingsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          
        },
            //   onMapCreated: 
            //   (GoogleMapController controller) async {
            //     _Controller = controller;
            //    setMapStyle();
            //  },
              
            ),
          ),
          SizedBox(),
          Stack(
                 // padding: EdgeInsets.all(0.0),
                  children: 
                    [SizedBox(
                     // height:950,
                     // height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 570,

                            // child: SizedBox(
                            //   // height: (MediaQuery.of(context).size.height / 0.5 ) -
                            //   //     (MediaQuery.of(context).size.height < 100
                            //   //         ? 126
                            //   //         : 05),
                            // ),
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
                                                        'Bonjour'),
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
                                                Padding(
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
                                                      ),
                                                     SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                     
                                    ],
                                  ),
                                  Divider(

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
                                          
                                        ],
                                      ),
                                    ),
                                    secondChild: IgnorePointer(
                                     
                                    
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
          prosseType != ProsseType.mapPin && prosseType != ProsseType.requset ? _getAppBarUI() : SizedBox(),
          // prosseType == ProsseType.dropOff
          //     ? AddressSelctionView(
          //         animationController: animationController,
          //         isSerchMode: isSerchMode,
          //         isUp: isUp,
          //         mapCallBack: () {
          //           animationController.animateTo(1, duration: Duration(milliseconds: 480)).then((f) {
          //             setState(() {
          //               prosseType = ProsseType.mapPin;
          //             });
          //           });
          //         },
          //         onSerchMode: (onSerchMode) {
          //           if (isSerchMode != onSerchMode) {
          //             setState(() {
          //               isSerchMode = onSerchMode;
          //             });
          //           }
          //         },
          //         onUp: (onUp) {
          //           if (isUp != onUp) {
          //             setState(() {
          //               isUp = onUp;
          //             });
          //           }
          //         },
          //         serachController: serachController,
          //         gpsClick: () {
          //           if (_mapController != null) {
          //             _mapController.animateCamera(
          //               CameraUpdate.newCameraPosition(
          //                 CameraPosition(
          //                   target: _doualaLatLong,
          //                   zoom: 16.0,
          //                   tilt: 24.0,
          //                 ),
          //               ),
          //             );
          //           }
          //           MyApp.changeTheme(context);
          //           setMapStyle();
          //         },
          //       )
          //     : prosseType == ProsseType.mapPin
          //         ? MapPinSelectionView(
          //             barText: AppLocalizations.of('105 William st, Chicago, US'),
          //             onBackClick: () {
          //               setState(() {
          //                 prosseType = ProsseType.dropOff;
          //               });
          //             },
          //             gpsClick: () {
          //               if (_mapController != null) {
          //                 _mapController.animateCamera(
          //                   CameraUpdate.newCameraPosition(
          //                     CameraPosition(
          //                       target: _doualaLatLong,
          //                       zoom: 16.0,
          //                       tilt: 24.0,
          //                     ),
          //                   ),
          //                 );
          //               }
          //               MyApp.changeTheme(context);
          //               setMapStyle();
          //             },
          //             callback: () {
          //               setState(() {
          //                 prosseType = ProsseType.requset;
          //               });
          //             },
          //           )
          //         : RequsetView(
          //             onBack: () {
          //               setState(() {
          //                 prosseType = ProsseType.dropOff;
          //               });
          //             },
          //           )
        ],
      ),
       floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 250.0),
            child: FloatingActionButton(
              child: Icon(Icons.my_location),
              onPressed: _currentLocation,
            ),
          ), 
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _currentLocation,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
        
      // ),
    );
    
  }


  

  Widget _getAppBarUI() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: Container(
                      color: Theme.of(context).cardColor,
                      padding: EdgeInsets.all(2),
                      child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32.0),
                          child: Image.asset(ConstanceData.userImage),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // void setMapStyle() async {
  //   if (_mapController != null) {
  //     if (globals.isLight)
  //       _mapController.setMapStyle(await DefaultAssetBundle.of(context).loadString("assets/jsonFile/light_mapstyle.json"));
  //     else
  //       _mapController.setMapStyle(await DefaultAssetBundle.of(context).loadString("assets/jsonFile/dark_mapstyle.json"));
  //   }
  // }
   Widget _emailUI() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: TextButton(
                 onPressed: () {
         Navigator.pushNamed(context, Routes.STEPPER, arguments: (Route<dynamic> route) => false);
          // Add your onPressed code here!
        },
                  child:Text(
                    
          'Demander une livraison',
          style: TextStyle(
              
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
              
        ),
        // icon: const Icon(
        //   Icons.delivery_dining_rounded,
        //   size: 40,
        //   color: Colors.white,
        // ),
      
                 
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
              
              ),
            ),
          ),
        ),
      );
    
  }
  //  Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}

enum ProsseType {
  dropOff,
  mapPin,
  requset,
}
