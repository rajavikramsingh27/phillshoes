import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:flutter/services.dart';
import 'package:stretchy_header/stretchy_header.dart';
import 'package:phillshoes/Views/Dashboard.dart';
import 'package:phillshoes/ViewService/DashboardService.dart';
import 'package:phillshoes/ViewService/SelectAnOption.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:location/location.dart';



class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final textController = TextEditingController();
  final fireStore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Location location = new Location();
  LocationData _locationData;

  @override
  void initState() {
    // TODO: implement initState
    kIsSignUp = true;

    Future.delayed(Duration(seconds:1), () async {
      getLocation();
    });
    super.initState();
  }

  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      _locationData = currentLocation;
    });

  }

  email_login() async {
    var tableName = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;

    showLoading(context);
    await _auth.signInWithEmailAndPassword(
        email:email,
        password:textController.text
    ).catchError((error) {
      print(error.toString());
      Toast.show(
          error.toString(),
          context,
          backgroundColor:Colors.red,
          duration:2
      );
    }).then((currentUser) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kType,kType);

      kType = prefs.getString(kType);
      print(kType);

      if (currentUser != null) {
        String latitude = kUnKnownLocation;
        String longitude = kUnKnownLocation;

        if (_locationData != null) {
          latitude = _locationData.latitude.toString();
          longitude = _locationData.longitude.toString();
        }
        fireStore.collection(tableName).document(currentUser.user.email+kConnect+currentUser.user.uid).updateData({
          klatitude:latitude,
          klongitude:longitude,
          kdevice_token:fcmToken
        }).catchError((error) {
          dismissLoading(context);
          print(error.toString());
          Toast.show(
              error.toString(),
              context,
              backgroundColor:Colors.red,
              duration:2
          );
        }).then((value) {
            dismissLoading(context);
          _auth.currentUser().then((currentUser) {
               showLoading(context);
            fireStore.collection(tableName).document(currentUser.email+kConnect+currentUser.uid).get().then((value) {
              dismissLoading(context);
                if (value != null) {
                    if (value.data[kuserRole] == kUser) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashboardService()));
                    }
                }
            }).catchError((error) {
              print(error.toString());
              Toast.show(
                  error.toString(),
                  context,
                  backgroundColor:Colors.red,
                  duration:2
              );
            });
          });
        });
      } else {
        dismissLoading(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    CircleAvatar circleAvtar(Color backgroundColor) {
      return CircleAvatar(
          backgroundColor:
          textController.text.isEmpty
              ? HexColor('D6D6D6') : HexColor('41CEA4'),
          child:IconButton(
            icon:Icon(
              Icons.arrow_forward,
              color:Colors.white,
            ),
            onPressed:() {
              if (textController.text.isEmpty) {
                Toast.show(
                    'Enter your password',
                    context,
                    backgroundColor:Colors.red,
                    duration:2
                );
              } else {
                email_login();
              }
            },
          )
      );
    }

    return Scaffold(
        backgroundColor:Colors.white,
        resizeToAvoidBottomPadding:true,
        body:Stack(
          children: <Widget>[
            StretchyHeader.singleChild(
                headerData:HeaderData(
                  headerHeight:350,
                  header:Container(
                    alignment:Alignment.center,
                    child:Stack(
                      children:<Widget>[
                        Container(
                            color:Colors.white,
                            width:sizeScreen.width,
                            child:Image.asset(curveBG,fit:BoxFit.fill,)
                        ),
                        Align(
                          alignment:Alignment.center,
                          child:Container(
                              width:240,
                              height:80,
                              child:Image.asset(logo)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                child:Container(
                  color:Colors.white,
                  child:Column(
                    children: <Widget>[
                      SizedBox(height:40,),
                      Column(
                        children: <Widget>[
                          Container(
                            width:sizeScreen.width,
                            padding:EdgeInsets.only(left:30,right:30),
                            child:Text(
                              'Enter your password below',
                              textAlign:TextAlign.left,
                              maxLines:2,
                              style:TextStyle(
                                  fontFamily:kFontPoppins,
                                  fontSize:24,
                                  fontWeight:FontWeight.w700
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:30,),
                      Container(
                          height:70,
                          margin:EdgeInsets.only(left:30,right:30),
                          decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius:BorderRadius.circular(12),
                            boxShadow:[
                              BoxShadow(
                                color:HexColor('#303030').withOpacity(0.15),
                                spreadRadius:3,
                                blurRadius:6,
                                offset: Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child:Stack(
                            children: <Widget>[
                              Positioned(
                                left:10,
                                right:70,
                                  height:70,
                                child:Container(
//                                  color:Colors.red,
                                  margin:EdgeInsets.all(0),
                                  child:Row(
                                    children: <Widget>[
                                      Container(
                                        margin:EdgeInsets.only(left:14),
                                        width:20,
                                        alignment:Alignment.centerRight,
                                        padding:EdgeInsets.only(right:0),
                                        child:Image.asset(user),
                                      ),
                                      Container(
                                        width:sizeScreen.width - 174,
                                        padding:EdgeInsets.only(left:16),
                                        child:TextField(
                                          controller:textController,
                                          obscureText:true,
                                          keyboardAppearance:Brightness.light,
                                          style:TextStyle(
                                            fontFamily:kFontPoppins,
                                            fontSize:16,
                                          ),
                                          onChanged:(text) {
                                            setState(() {

                                            });
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:'********'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ),
                              Positioned(
                                  top:16,
                                  right:20,
                                  child:circleAvtar(HexColor('D6D6D6'))
                              )
                            ],
                          )
                      ),
                      SizedBox(height:30,),
                    ],
                  ),
                )
            ),
            Positioned(
                top:40,
                left:35,
                child:CircleAvatar(
                    backgroundColor:Colors.white,
                    child:IconButton(
                      icon:Icon(
                        Icons.arrow_back,
                        color:HexColor('2DBB54'),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                      },
                    )
                )
            )
          ],
        )
    );
  }
}
