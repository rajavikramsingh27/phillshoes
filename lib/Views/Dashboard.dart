import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:phillshoes/Views/Home.dart';
import 'package:phillshoes/Views/ChooseServiceProvider.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/Profile.dart';
import 'package:phillshoes/ViewService/ProfileService.dart';
import 'package:phillshoes/Views/ServiceHistoryUser.dart';
import 'package:phillshoes/Views/LoginType.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phillshoes/ViewService/Location.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dart_notification_center/dart_notification_center.dart';



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {
  var visibiltySelectAnOption = true;
  var visibiltyConfirm = false;
  var visibiltyTryAgain = false;

  var visibiltyBottomView = true;
  bool isIgnoring = true;
  double _dragStart = 0.0;
  double _hieght = 290.0; //35;
  double _currentPosition = 0.0;
  GlobalKey _cardKey = GlobalKey();

  var indexSelected = -1;
  String selectedServiceID = '';

//  List<Map<String, dynamic>> arrUserDetails = [];
  List<Map<String, dynamic>> arrServiceList = [];
  Map<String,dynamic> dictUserDetails = {};

  final fireStore = Firestore.instance;
  var storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Timer _timer;
  int _start = 240;

  @override
  void initState() {
    Future.delayed(Duration(seconds:1), () async {
      getData_FireBaseFireStore();

      QuerySnapshot querySnapshot = await fireStore.collection(kFireBaseServices).getDocuments();
      arrServiceList = querySnapshot.documents.map((DocumentSnapshot doc) {
        return doc.data;
      }).toList();

      setState(() {

      });
    });
    
    DartNotificationCenter.subscribe(
      channel:kLocationUpdate,
      observer:this,
      onNotification: (result) {
        print(result);
      setState(() {
          
        });
      },
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  getData_FireBaseFireStore() async {
    showLoading(context);
    await _auth.currentUser().then((currentUser) async {
      var tableName = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
      await fireStore.collection(tableName).document(currentUser.email+kConnect+currentUser.uid).get().then((value){
        dictUserDetails = value.data;
        setState(() {

        });
      }).catchError((error) {
        print(error.toString());
        Toast.show(
            error.toString(),
            context,
            backgroundColor:Colors.red,
            duration:2
        );
      }).then((value) {
        dismissLoading(context);
      });
    });
  }


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(() {
          if (_start < 1) {
            timer.cancel();
            isIgnoring = false;
            visibiltySelectAnOption = false;
            visibiltyConfirm = false;
            visibiltyTryAgain = true;
            setState(() {

            });
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }


  find_provider() async {
    showLoading(context);
    QuerySnapshot querySnapshot = await fireStore.collection(kFireBaseServiceProviders).getDocuments();
    List<Map<String, dynamic>> arrServiceList = querySnapshot.documents.map((DocumentSnapshot doc) {
      return doc.data;
    }).toList();
    print(arrServiceList);
    dismissLoading(context);

    if (arrServiceList.length > 0) {
      _timer.cancel();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChooseServiceProvider()));
    } else {
      Toast.show(
          'Service Providers are not available',
          context,
          backgroundColor:Colors.red,
          duration:2
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    var arrHeader = ['Profile','History','Invite Friends','Promo Codes','Settings','Support','Log Out'];

    GoogleMap googleMap;

    const double CAMERA_ZOOM = 13;
    const double CAMERA_TILT = 0;
    const double CAMERA_BEARING = 30;
    const LatLng SOURCE_LOCATION = LatLng(26.9124,75.7873);

    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION
    );

//    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    if (googleMap == null) {
      googleMap = GoogleMap(
        initialCameraPosition:initialLocation,
        myLocationEnabled: false,
        myLocationButtonEnabled:false,
//        compassEnabled: true,
//        tiltGesturesEnabled: false,
//        markers: _markers,
//        polylines: _polylines,
        mapType: MapType.normal,
//        onMapCreated:onMapCreated
        compassEnabled:false,
//        mapType: MapType.normal,
//        trackCameraPosition: true,

        padding: EdgeInsets.only(top: 1.0,),
      );
    }

    void showDialog() {
      showGeneralDialog(
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.7),
        transitionDuration: Duration(milliseconds:300),
        context: context,
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.bottomCenter,
            child:Material(
              color: Colors.transparent,
              child:Container(
                  height:220,
                  width:sizeScreen.width,
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  child:SafeArea(
                    top:false,
                    child:Column(
                      children: <Widget>[
                        SizedBox(
                          height:30,
                        ),
                        Text(
                          'Are you sure?',
                          style:TextStyle(
                              color:Colors.black,
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.bold,
                              fontSize:18
                          ),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        Text(
                          'Do you want to log out ?',
                          style:TextStyle(
                              color:Colors.black,
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.w500,
                              fontSize:16
                          ),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        FlatButton(
                          child:Text(
                            'Log Out',
                            style:TextStyle(
                                color:Colors.red,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w500,
                                fontSize:18
                            ),
                          ),
                          onPressed:() async {
                            await _auth.signOut().then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginTypes()));
                            });
                          },
                        ),
                        FlatButton(
                          child:Text(
                            'Cancel',
                            style:TextStyle(
                                color:Colors.grey,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w500,
                                fontSize:18
                            ),
                          ),
                          onPressed:() {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        },
      );
    }

    return Scaffold(
        appBar:setAppBar(),
        drawer:Drawer(
        child:SafeArea(
          child:ListView(
            padding:EdgeInsets.only(top: 20),
            children: <Widget>[
              Container(
                height:120,
                color:Colors.white,
                child:Column(
                  children: <Widget>[
                    Container(
                      color:Colors.white,
                      child:Row(
                        children: <Widget>[
                          SizedBox(width:20,),
                          Container(
                            decoration:BoxDecoration(
                              color:Colors.white,
                              borderRadius:BorderRadius.circular(30),
                            ),
                            child:ClipRRect(
                                borderRadius:BorderRadius.circular(30),
                                child:FadeInImage(
                                  fit:BoxFit.fill,
                                  height:44,
                                  width:44,
                                  image:NetworkImage(
                                      (dictUserDetails[kprofile] == null)
                                          ? ''
                                          : dictUserDetails[kprofile]
                                  ),
                                  placeholder:AssetImage(userPerson),
                                )
                            ),
                          ),
                          Container(
                            margin:EdgeInsets.only(left:20),
                            child:Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Good morning,',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w600,
                                      fontSize:12
                                  ),
                                ),
                                SizedBox(height:5,),
                                Text(
                                  dictUserDetails[kname],
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w700,
                                      fontSize:24
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height:44),
                    Container(
                      height:1,
                      width:sizeScreen.width,
                      color:Colors.grey.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
              ListView.builder(
//              scrollDirection:Axis.vertical,
                itemCount:arrHeader.length,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(0.0),
                itemBuilder:(context, index) {
                  return GestureDetector(
                    onTap:() {
                      Navigator.pop(context); // close the
                      if (index == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileService()));
                      } else if (index == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServiceHistoryUser()));
                      }  else if (index == arrHeader.length-1) {
                        showDialog();
                      }
                      // drawer
                    },
                    child:Container(
                      color:Colors.white,
                      height:50,
                      margin:EdgeInsets.only(left:20),
                      child:Text(
                        arrHeader[index],
                        style:TextStyle(
                            color:Colors.black,
                            fontFamily:kFontPoppins,
                            fontWeight:FontWeight.w700,
                            fontSize:24
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height:100,
                child:Container(
                  color:Colors.white,
                ),
              ),
              Container(
//              height: 40,
                  margin:EdgeInsets.only(left:20),
                  color:Colors.white,
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Do more',
                        style:TextStyle(
                            color:HexColor('#726E6E'),
                            fontFamily:kFontPoppins,
                            fontWeight:FontWeight.w700,
                            fontSize:12
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Text(
                        'Make money driving',
                        style:TextStyle(
                            color:HexColor('#726E6E'),
                            fontFamily:kFontPoppins,
//                        fontWeight:FontWeight.w700,
                            fontSize:12
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Text(
                        'Rate us on store',
                        style:TextStyle(
                            color:HexColor('#726E6E'),
                            fontFamily:kFontPoppins,
//                        fontWeight:FontWeight.w700,
                            fontSize:12
                        ),
                      ),
                      SizedBox(
                        height:50,
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
      ),
        body:Container(
          width:sizeScreen.width,
          height:sizeScreen.height,
          child:Stack(
            children: <Widget>[
              Positioned(
                top:0,
                bottom:0,
                left:0,
                right:0,
                child:Container(
                  child:googleMap,
                ),
              ),
              Positioned(
                  bottom:0,
                  left:0,
                  right:0,
                  child:SafeArea(
                    child:Visibility(
                      visible:visibiltyBottomView,
                      child:Container(
                        child:Column(
                          children: <Widget>[
                            GestureDetector(
                              child:Container(
                                  height:visibiltySelectAnOption ? _hieght : 0,
                                  width: visibiltySelectAnOption ?  sizeScreen.width-40 : 0,
//                                  margin:EdgeInsets.only(left:20),
                                  decoration:BoxDecoration(
                                    color:Colors.white,
                                    boxShadow:[
                                      BoxShadow(
                                        color:Colors.grey.withOpacity(0.4),
                                        spreadRadius:2,
                                        blurRadius:8,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    borderRadius:BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0),
                                    ),
                                  ),
                                  child:SingleChildScrollView(
                                    physics:NeverScrollableScrollPhysics(),
                                    child:Column(
                                      children: <Widget>[
                                        Container(
                                          height:3,
                                          width:130,
                                          margin:EdgeInsets.only(top:10),
                                          color:HexColor('C3CDD6'),
                                        ),
                                        Container(
                                          height:44,
                                          margin:EdgeInsets.only(top:10),
                                          child:Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              IconButton(
                                                icon:Icon(
                                                  Icons.arrow_back_ios,
                                                  color:HexColor('#78B6FA'),
                                                ),
                                                onPressed:() {
                                                  print('object');
                                                },
                                              ),
                                              Text(
                                                'Select an option:',
                                                style:TextStyle(
                                                    color:Colors.black,
                                                    fontWeight:FontWeight.w700,
                                                    fontSize:18
                                                ),
                                              ),
                                              IconButton(
                                                icon:Icon(
                                                  Icons.arrow_forward_ios,
                                                  color:HexColor('#78B6FA'),
                                                ),
                                                onPressed:() {
                                                  print('object');
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height:82,
                                          width:sizeScreen.width-40,
                                          margin:EdgeInsets.only(top:20,bottom:13),
                                          child:ListView.builder(
                                            padding: EdgeInsets.only(
                                              left:10,
                                              right:10,
                                            ),
                                            scrollDirection:Axis.horizontal,
                                            itemCount:arrServiceList.length,
                                            itemBuilder:(context, index) {
                                              return GestureDetector(
                                                onTap:() {
                                                  setState(() {
                                                    indexSelected = index;
                                                    selectedServiceID = arrServiceList[index][kid];
                                                  });
                                                },
                                                child:Container(
                                                    width:170,
                                                    margin:EdgeInsets.only(right:10,bottom:10),
                                                    decoration:BoxDecoration(
                                                      color: (indexSelected == index)
                                                          ? HexColor('#78B6FA')
                                                          : HexColor('D6D6D6'),
                                                      borderRadius:BorderRadius.circular(12),
                                                      boxShadow:[
                                                        BoxShadow(
                                                          color: (indexSelected == index)
                                                              ? HexColor('#78B6FA').withOpacity(0.6)
                                                              : HexColor('D6D6D6').withOpacity(0.6),
                                                          spreadRadius:5,
                                                          blurRadius:13,
                                                          offset: Offset(0, 5),
                                                        )
                                                      ],
                                                    ),
                                                    child:Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                          top:0,
                                                          left:16,
                                                          bottom:0,
                                                          child:Column(
                                                            crossAxisAlignment:CrossAxisAlignment.start,
                                                            mainAxisAlignment:MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Text(
                                                                arrServiceList[index][kname],
                                                                style:TextStyle(
                                                                    color: (indexSelected == index)
                                                                        ? Colors.white
                                                                        : Colors.black,
                                                                    fontWeight:FontWeight.w700,
                                                                    fontSize:12
                                                                ),
                                                              ),
//                                                              SizedBox(height:10),
//                                                              Text(
//                                                                'Rs. '+arrPrice[index],
//                                                                style:TextStyle(
//                                                                    color: (indexSelected == index)
//                                                                        ? Colors.white
//                                                                        : Colors.black
//                                                                ),
//                                                              ),
//                                                              SizedBox(height:4,),
//                                                              Text(
//                                                                arrTime[index]+' MIN',
//                                                                style:TextStyle(
//                                                                    color: (indexSelected == index)
//                                                                        ? Colors.white
//                                                                        : Colors.black,
//                                                                    fontWeight:FontWeight.w300,
//                                                                    fontSize:12
//                                                                ),
//                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom:10,
                                                          right:10,
                                                          child:Container(
                                                            height:44,
                                                            width:44,
                                                            child:FadeInImage(
                                                              height:44,
                                                              width:44,
                                                              image:NetworkImage(
                                                                  arrServiceList[index][kIcon]
                                                              ),
                                                              placeholder:AssetImage('assets/home.png'),
                                                            )
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          height:32,
                                          width:sizeScreen.width,
                                          child:Row(
                                            children: <Widget>[
                                              SizedBox(width:10,),
                                              Image.asset(
                                                'assets/calendar.png',
                                                width:34,
                                                height:32,
                                              ),
                                              SizedBox(width:0,),
                                              FlatButton(onPressed:() {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Home()));
                                              },
                                                textColor:Colors.white,
                                                child:Text(
                                                  'Hire the expert for a month',
                                                  style:TextStyle(
                                                      decoration: TextDecoration.underline,
                                                      color:HexColor('#2172A1'),
                                                      fontWeight:FontWeight.w500,
                                                      fontSize:15
                                                  ),
                                                ),)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment:Alignment.center,
                                          margin:EdgeInsets.only(top:14),
                                          height:40,
                                          width:100,
                                          decoration:BoxDecoration(
                                              color:HexColor('35ADA3'),
                                              borderRadius:BorderRadius.circular(12)
                                          ),
                                          child:FlatButton(
                                            child:Text(
                                              'Confirm',
                                              style:TextStyle(
                                                  color:Colors.white,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:12
                                              ),
                                            ),
                                            onPressed: () {
                                              if (!visibiltyMyHome) {
                                                Toast.show(
                                                    'Select an address',
                                                    context,
                                                    backgroundColor:Colors.red,
                                                    duration:2
                                                );
                                              } else if (selectedServiceID.isEmpty) {
                                                print(selectedServiceID);
                                                Toast.show(
                                                    'Select a service',
                                                    context,
                                                    backgroundColor:Colors.red,
                                                    duration:2
                                                );
                                              } else {
                                                find_provider();
                                                startTimer();
                                                setState(() {
                                                  visibiltySelectAnOption = false;
                                                  visibiltyConfirm = true;
                                                  visibiltyTryAgain = false;
                                                });
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ),
                            SafeArea(
                                child:Container(
                                  child:AnimatedContainer(
                                    duration:Duration(milliseconds:100),
                                    curve:Curves.easeIn,
                                    height:visibiltyTryAgain ? 300 : 0,
                                    width: visibiltyTryAgain ?  sizeScreen.width : 0,
                                    child:Container(
//                          width:MediaQuery.of(context).size.width,
//                          height:300,
                                      margin:EdgeInsets.only(bottom:0, left:20, right:20),
                                      decoration:BoxDecoration(
                                        color:Colors.white,
                                        borderRadius:BorderRadius.circular(40),
                                        boxShadow:[
                                          BoxShadow(
                                            color:Colors.grey.withOpacity(0.5),
                                            spreadRadius:2,
                                            blurRadius:10,
                                            offset: Offset(0,0),
                                          )
                                        ],
                                      ),
                                      child:Stack(
                                        children: <Widget>[
                                          Container(
                                            margin:EdgeInsets.only(
                                                top:25,
                                                left:30,
                                                right:30,
                                                bottom:30
                                            ),
                                            height:5,
//                              color:Colors.red,
                                            child:Row(
                                              children: <Widget>[
                                                Container(
                                                  color:HexColor('77B5FA'),
                                                  width:(sizeScreen.width-100)/4,
                                                ),
                                                Container(
                                                  color:HexColor('EEF2F6'),
                                                  width:(sizeScreen.width-100)/4,
                                                ),
                                                Container(
                                                  color:HexColor('77B5FA'),
                                                  width:(sizeScreen.width-100)/4,
                                                ),
                                                Container(
                                                  color:HexColor('EEF2F6'),
                                                  width:(sizeScreen.width-100)/4,
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top:10,
                                            bottom:0,
                                            left:0,
                                            right:0,
                                            child:Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top:25,
                                                  bottom:0,
                                                  left:0,
                                                  right:0,
                                                  child:Column(
                                                    children: <Widget>[
                                                      Container(
                                                        margin:EdgeInsets.only(top:30,left:30,right:30),
                                                        child:Text(
                                                            'Sorry we are unable to find you '
                                                                'any service please try after some time',
                                                            style:TextStyle(
//                                  fontFamily:kFontPoppins,
//                                      fontWeight:FontWeight.w300,
                                                                color:HexColor('2172A1'),
                                                                fontSize:20)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                    bottom:0,
                                                    left:0,
                                                    right:0,
                                                    child:Column(
                                                      children: <Widget>[
                                                        Container(
                                                          height:45,
                                                          width:sizeScreen.width - 90,
                                                          margin:EdgeInsets.only(left:50,right:50,bottom:20),
                                                          decoration:BoxDecoration(
                                                            gradient:LinearGradient(
                                                              begin:Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                              colors:[
                                                                HexColor('38B3A3'),
                                                                HexColor('2D95A2'),
                                                                HexColor('2070A0'),
                                                              ],
                                                            ),
                                                            borderRadius:BorderRadius.circular(22),
                                                          ),
                                                          child:FlatButton(
                                                            textColor:Colors.white,
                                                            child:Text(
                                                              'Try Again',
                                                              textAlign:TextAlign.left,
                                                              style:TextStyle(
                                                                  color:Colors.white,
                                                                  fontWeight:FontWeight.w700,
                                                                  fontSize:16
                                                              ),
                                                            ),
                                                            onPressed:() {
                                                              _start = 240;
                                                              find_provider();
                                                              setState(() {
                                                                visibiltySelectAnOption = false;
                                                                visibiltyConfirm = true;
                                                                visibiltyTryAgain = false;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          height:45,
                                                          width:sizeScreen.width - 90,
                                                          margin:EdgeInsets.only(left:50,right:50,bottom:30),
                                                          decoration:BoxDecoration(
                                                            gradient:LinearGradient(
                                                              begin:Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                              colors:[
                                                                HexColor('38B3A3'),
                                                                HexColor('2D95A2'),
                                                                HexColor('2070A0'),
                                                              ],
                                                            ),
                                                            borderRadius:BorderRadius.circular(22),
                                                          ),
                                                          child:FlatButton(
                                                            textColor:Colors.white,
                                                            child:Text(
                                                              'Confirm',
                                                              textAlign:TextAlign.left,
                                                              style:TextStyle(
                                                                  color:Colors.white,
                                                                  fontWeight:FontWeight.w700,
                                                                  fontSize:16
                                                              ),
                                                            ),
                                                            onPressed:() {
                                                              setState(() {
                                                                visibiltySelectAnOption = true;
                                                                visibiltyConfirm = false;
                                                                visibiltyTryAgain = false;
                                                              });

                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            SafeArea(
                              child:AnimatedContainer(
                                duration:Duration(milliseconds:10),
                                curve:Curves.easeIn,
                                height:visibiltyConfirm ? 300 : 0,
                                width: visibiltyConfirm ?  sizeScreen.width : 0,
                                child:Container(
                                  margin:EdgeInsets.only(bottom:0, left:20, right:20),
                                  decoration:BoxDecoration(
                                    color:Colors.white,
                                    borderRadius:BorderRadius.circular(40),
                                    boxShadow:[
                                      BoxShadow(
                                        color:Colors.grey.withOpacity(0.5),
                                        spreadRadius:2,
                                        blurRadius:10,
                                        offset: Offset(0,0),
                                      )
                                    ],
                                  ),
                                  child:Stack(
                                    children: <Widget>[
                                      Container(
                                        margin:EdgeInsets.only(
                                            top:25,
                                            left:30,
                                            right:30,
                                            bottom:30
                                        ),
                                        height:5,
                                        child:Row(
                                          children: <Widget>[
                                            Container(
                                              color:HexColor('77B5FA'),
                                              width:(sizeScreen.width-100)/4,
                                            ),
                                            Container(
                                              color:HexColor('EEF2F6'),
                                              width:(sizeScreen.width-100)/4,
                                            ),
                                            Container(
                                              color:HexColor('77B5FA'),
                                              width:(sizeScreen.width-100)/4,
                                            ),
                                            Container(
                                              color:HexColor('EEF2F6'),
                                              width:(sizeScreen.width-100)/4,
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top:10,
                                        bottom:0,
                                        left:0,
                                        right:0,
                                        child:Stack(
                                          children: <Widget>[
                                            Positioned(
                                              top:25,
                                              bottom:0,
                                              left:0,
                                              right:0,
                                              child:IgnorePointer(
                                                ignoring:false,
                                                child:Column(
                                                  children: <Widget>[
                                                    Container(
                                                      child:Text(
                                                          'We are looking for the best',
                                                          style:TextStyle(
                                                              color:HexColor('2172A1'),
                                                              fontSize:20)
                                                      ),
                                                      margin:EdgeInsets.only(top:30),
                                                    ),
                                                    Container(
                                                      child:Text(
                                                          ' possible option for you',
                                                          style:TextStyle(
                                                              color:HexColor('2172A1'),
                                                              fontSize:20)
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ),
                                            Positioned(
                                              bottom:0,
                                              left:0,
                                              right:0,
                                              child:Container(
                                                height:45,
                                                width:sizeScreen.width - 90,
                                                margin:EdgeInsets.only(left:50,right:50,bottom:30),
                                                decoration:BoxDecoration(
                                                  gradient:LinearGradient(
                                                    begin:Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors:[
                                                      HexColor('38B3A3'),
                                                      HexColor('2D95A2'),
                                                      HexColor('2070A0'),
                                                    ],
                                                  ),
                                                  borderRadius:BorderRadius.circular(22),
                                                ),
                                                child:FlatButton(
                                                  textColor:Colors.white,
                                                  child:Text(
                                                    'Confirm',
                                                    textAlign:TextAlign.left,
                                                    style:TextStyle(
                                                        color:Colors.white,
//                                        fontFamily:kFontPoppins,
                                                        fontWeight:FontWeight.w700,
                                                        fontSize:16
                                                    ),
                                                  ),
                                                  onPressed:() {
//                                                    _start = 20;
                                                  isIgnoring = true;
                                                    startTimer();
                                                    setState(() {
                                                      visibiltySelectAnOption = false;
                                                      visibiltyConfirm = false;
                                                      visibiltyTryAgain = true;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child:Text(
                                                  (_start/60).toStringAsFixed(0)+':'+(_start%60).toString(),
                                                  textAlign:TextAlign.center,
                                                  style:TextStyle(
                                                      color:HexColor('2DBB54'),
                                                      fontSize:25)
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                  )
              ),
              Positioned(
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding:EdgeInsets.only(top:0,bottom:20),
                      decoration:BoxDecoration(
                        color:Colors.white,
                        boxShadow:[
                          setShadow()
                        ],
                      ),
                      child:Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin:EdgeInsets.only(left:20,top:10),
                            child:SafeArea(
                                child:CircleAvatar(
                                  radius:22,
                                  backgroundColor:HexColor('41CEA4'),
                                  child:Builder(
                                    builder:(context) => IconButton(
                                      icon:CircleAvatar(
                                        radius:22,
                                        backgroundColor:HexColor('41CEA4'),
                                        child:Icon(
                                          Icons.menu,
                                          color:Colors.white,
                                        ),
                                      ),
                                      onPressed: () => Scaffold.of(context).openDrawer(),
                                    ),
                                  ),
                                )
                            ),
                          ),
                          SizedBox(height:10),
                          Container(
                            height:72,
                            color:Colors.white.withOpacity(0.8),
                            child:Row(
                              children: <Widget>[
                                SizedBox(width:20,),
                                Container(
                                  decoration:BoxDecoration(
                                    color:Colors.white,
                                    borderRadius:BorderRadius.circular(30),
                                    boxShadow:[
                                      BoxShadow(
                                        color:Colors.grey.withOpacity(0.5),
                                        spreadRadius:2,
                                        blurRadius:10,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                  ),
                                  child:ClipRRect(
                                      borderRadius:BorderRadius.circular(30),
                                      child:FadeInImage(
                                        fit:BoxFit.fill,
                                        height:44,
                                        width:44,
                                        image:NetworkImage(
                                            dictUserDetails[kprofile]
                                        ),
                                        placeholder:AssetImage(userPerson),
                                      )
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.only(left:20),
                                  width:sizeScreen.width-95,
                                  child:Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        dictUserDetails[kname],
                                        style:TextStyle(
                                            color:HexColor('5D9FFF'),
                                            fontWeight:FontWeight.w600,
                                            fontSize:12
                                        ),
                                        maxLines:2,
                                      ),
                                      SizedBox(height:10,),
                                      Text(
                                        'What help do you need today?',
                                        style:TextStyle(
                                            color:Colors.black,
                                            fontWeight:FontWeight.w600,
                                            fontSize:20
                                        ),
                                        maxLines:2,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Visibility(
                          visible:visibiltySearchForDest,
                          child:FlatButton(
                            textColor:Colors.white,
                            padding:EdgeInsets.only(left:0,right:0),
                            child:Container(
                              height:60,
                              margin:EdgeInsets.only(left:20,top:20),
                              width:sizeScreen.width-40,
                              decoration:BoxDecoration(
                                color:Colors.white,
                                borderRadius:BorderRadius.circular(12),
                                boxShadow:[
                                  BoxShadow(
                                    color:Colors.grey.withOpacity(0.5),
                                    spreadRadius:1,
                                    blurRadius:7,
                                    offset: Offset(0,6),
                                  )
                                ],
                              ),
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      width:sizeScreen.width-100,
                                      margin:EdgeInsets.only(left:16),
                                      child:Text(
                                        'Search for a destination',
                                        style:TextStyle(
                                            color:Colors.black54,
                                            fontWeight:FontWeight.w600,
                                            fontSize:16
                                        ),
                                        textAlign: TextAlign.left,
                                      )
                                  ),
                                  Container(
                                    margin:EdgeInsets.only(right:20),
                                    child:Icon(
                                      Icons.search,
                                      color:HexColor('D6D6D6'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onPressed:() {
                              kLocation = kUser;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Location()));
                            },
                          )
                        ),
                        Visibility(
                          visible:visibiltyMyHome,
                          child:Container(
                            margin:EdgeInsets.only(left:20,top:20),
                            padding:EdgeInsets.only(bottom:16),
//                            height:80,
                            width:sizeScreen.width-40,
                            decoration:BoxDecoration(
                              color:Colors.white,
                              borderRadius:BorderRadius.circular(12),
                              boxShadow:[
                                BoxShadow(
                                  color:Colors.grey.withOpacity(0.5),
                                  spreadRadius:1,
                                  blurRadius:7,
                                  offset: Offset(0,6),
                                )
                              ],
                            ),
                            child:Row(
                              children: <Widget>[
                                SizedBox(width:20,),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height:8,
                                      width:8,
                                      margin:EdgeInsets.only(top:16),
                                      decoration:BoxDecoration(
                                          color:HexColor('2DBB54'),
                                          borderRadius:BorderRadius.circular(4)
                                      ),
                                    ),
                                    Container(
                                      height:4,
                                      width:4,
                                      margin:EdgeInsets.only(top:4),
                                      decoration:BoxDecoration(
                                          color:Colors.grey.withOpacity(0.7),
                                          borderRadius:BorderRadius.circular(3)
                                      ),
                                    ),
                                    Container(
                                      height:4,
                                      width:4,
                                      margin:EdgeInsets.only(top:4),
                                      decoration:BoxDecoration(
                                          color:Colors.grey.withOpacity(0.7),
                                          borderRadius:BorderRadius.circular(3)
                                      ),
                                    ),
                                    Container(
                                      height:4,
                                      width:4,
                                      margin:EdgeInsets.only(top:4),
                                      decoration:BoxDecoration(
                                          color:Colors.grey.withOpacity(0.7),
                                          borderRadius:BorderRadius.circular(3)
                                      ),
                                    ),
                                    Container(
                                      height:4,
                                      width:4,
                                      margin:EdgeInsets.only(top:4),
                                      decoration:BoxDecoration(
                                          color:Colors.grey.withOpacity(0.7),
                                          borderRadius:BorderRadius.circular(3)
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width:20,),
                                Container(
                                  width:sizeScreen.width-124,
                                  padding:EdgeInsets.only(right:10),
                                  child:Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height:26,),
                                      Text(
                                        kSelectedLocation,
                                        style:TextStyle(
                                            color:HexColor('#D6D6D6'),
                                            fontWeight:FontWeight.w300,
                                            fontSize:12
                                        ),
                                        maxLines:2,
                                      ),
                                      SizedBox(height:3,),
                                      Text(
                                        'My Home',
                                        style:TextStyle(
                                            color:Colors.black,
//                          fontFamily:kFontPoppins,
                                            fontWeight:FontWeight.w700,
                                            fontSize:16
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height:22,
                                    width:22,
//                      color:Colors.green,
                                    padding:EdgeInsets.all(0),
                                    child:Stack(
                                      children: <Widget>[
                                        IconButton(
                                          padding:EdgeInsets.all(0),
                                          icon:Icon(
                                            Icons.cancel,
                                            size:22,
                                            color:HexColor('D6D6D6'),
                                          ),
                                          onPressed:() {
                                            print('object');
                                            setState(() {
                                              visibiltySearchForDest = !visibiltySearchForDest;
                                              visibiltyMyHome = !visibiltyMyHome;
                                            });
                                          },
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

}


