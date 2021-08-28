import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';

import 'package:phillshoes/Views/NumberScreen.dart';
import 'package:stretchy_header/stretchy_header.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'dart:convert' show utf8, base64;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phillshoes/Views/OTP.dart';
import 'package:phillshoes/ViewService/SelectAnOption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:location/location.dart';
import 'package:phillshoes/Views/Dashboard.dart';



class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool visibleEmail = true;
  bool visibleMobile = false;

  final _Email = TextEditingController();
  final _Number = TextEditingController();
  final _Password = TextEditingController();
  final _ConfirmPassword = TextEditingController();

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


  setData_FireBaseFireStore() async {
    _auth.currentUser().then((currentUser) {
      var dictData = {
        kuserID:currentUser.uid,
        kuserRole:kType,
        kemail_ID:currentUser.email,
        kpassword:_Password.text,
        kpassword_string:base64.encode(utf8.encode(_Password.text)),
        kcreated:nanosecondsParam(),
        kdevice_type:Platform.isIOS ? 'iOS' : 'Android',
        kdevice_token:fcmToken,
        kname:'',
        kmobile:'',
        kprofile:'',
        kage:'',
        klanguage:'',
        kotp:'',
        klatitude:_locationData.latitude,
        klongitude:_locationData.longitude,
        kservice_id:'',
        kservice_name:'',
        kuser_from:'',
        klocal_address:'',
        kis_verified: '',
        kis_identify:'',
        kis_expert:'',
        kis_online:'',
      };
      print(dictData);
      String fireBaseStorage = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
      print(fireStore.collection(fireBaseStorage).document(currentUser.email+kConnect+currentUser.uid));

      fireStore.collection(fireBaseStorage).document(currentUser.email+kConnect+currentUser.uid).setData(
          dictData
      ).catchError((error) {
        print(error.toString());
        Toast.show(
            error.toString(),
            context,
            backgroundColor:Colors.red,
            duration:2
        );
      }).then((value) async {
        print('signed In');
      });
    });
  }

  email_signup() async {
    showLoading(context);
    await _auth.createUserWithEmailAndPassword(
        email:_Email.text,
        password:_Password.text
    ).catchError((error) {
      Toast.show(
          error.toString(),
          context,
          backgroundColor:Colors.red,
          duration:2
      );
    }).then((value) async {
      dismissLoading(context);
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(kType,kType);
        setData_FireBaseFireStore();

        if (value != null) {
          if (kType == kUser) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectAnOption()));
          }
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    login_signup_OTP() async {

    }

    return Scaffold(
        backgroundColor: HexColor('#EEF5FF'),
        resizeToAvoidBottomPadding: true,
        body: Stack(
          children: <Widget>[
            StretchyHeader.singleChild(
                headerData: HeaderData(
                  headerHeight: 230,
                  header: Container(
                    color: HexColor('#EEF5FF'),
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        Container(
                            color: HexColor('#EEF5FF'),
                            width: sizeScreen.width,
                            child: Image.asset(
                              curveBG,
                              fit: BoxFit.fill,
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 240, height: 80, child: Image.asset(logo)),
                        ),
                      ],
                    ),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                        color: HexColor('#EEF5FF'),
                        height: 450,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: HexColor('#EEF5FF'),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                signBG,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 30, top: 50),
//                            color:Colors.red,
                                width: MediaQuery.of(context).size.width - 60,
//                            height:70,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          margin: EdgeInsets.only(left: 16),
                                          child: FlatButton(
                                            textColor: Colors.white,
                                            child: Text(
                                              'Mobile',
                                              style: TextStyle(
                                                  color: HexColor('#000000')
                                                      .withOpacity(0.3),
                                                  fontFamily: kFontRaleway,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            onPressed: () {
                                              visibleEmail = false;
                                              visibleMobile = true;
                                              setState(() {

                                                return NumberScreen();

                                              });
                                            },
                                          ),
                                        ),
                                        Visibility(
                                          visible: visibleMobile,
                                          maintainState: true,
                                          maintainAnimation: true,
                                          maintainSize: true,
                                          maintainInteractivity: true,
                                          child: Container(
                                            height: 5,
                                            width: 100,
                                            margin: EdgeInsets.only(left: 16),
                                            decoration: BoxDecoration(
                                                color: HexColor('#5D9FFF'),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          margin: EdgeInsets.only(right: 16),
                                          child: FlatButton(
                                            textColor: Colors.white,
                                            child: Text(
                                              'Email',
                                              style: TextStyle(
                                                  color: HexColor('#000000')
                                                      .withOpacity(0.3),
                                                  fontFamily: kFontRaleway,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            onPressed: () {
                                              visibleEmail = true;
                                              visibleMobile = false;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        Visibility(
                                          visible: visibleEmail,
                                          maintainState: true,
                                          maintainAnimation: true,
                                          maintainSize: true,
                                          maintainInteractivity: true,
                                          child: Container(
                                            height: 5,
                                            width: 100,
                                            margin: EdgeInsets.only(right: 16),
                                            decoration: BoxDecoration(
                                                color: HexColor('#5D9FFF'),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 140,
                              ),
                              Container(
                                  height: 50,
                                  child: Stack(
                                    children: <Widget>[
                                      Visibility(
                                        visible: visibleEmail,
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 30, right: 10),
                                            height: 50,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Image.asset(user),
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: sizeScreen.width -
                                                          130,
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child:TextField(
                                                        keyboardType:TextInputType.emailAddress,
                                                        controller: _Email,
                                                        keyboardAppearance:Brightness.light,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              kFontPoppins,
                                                          fontSize: 16,
                                                        ),
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Email ID / username'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  height: 1,
                                                  color: HexColor('#707070'),
                                                )
                                              ],
                                            )),
                                      ),
                                      Visibility(
                                        visible: visibleMobile,
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 30, right: 10),
                                            height: 50,
                                            color: Colors.white,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Icon(
                                                        Icons.call,
                                                        color:
                                                            HexColor('#5D9FFF'),
                                                      ),
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: sizeScreen.width -
                                                          130,
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: TextField(
                                                        keyboardType:TextInputType.numberWithOptions(
                                                        ),
                                                        controller:_Number,
                                                        keyboardAppearance:
                                                            Brightness.light,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              kFontPoppins,
                                                          fontSize: 16,
                                                        ),
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Mobile number'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  height: 1,
                                                  color: HexColor('#707070'),
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  )),
                              // create new password
                              Visibility(
                                visible:visibleEmail,
                                child:Container(
                                    margin: EdgeInsets.only(
                                        left: 30, top: 10, right: 10),
                                    height: 50,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              child: Image.asset(eye),
                                              height: 16,
                                            ),
                                            Container(
                                              width: sizeScreen.width - 130,
                                              padding: EdgeInsets.only(left: 10),
                                              child: TextField(
                                                controller: _Password,
                                                obscureText: true,
                                                keyboardAppearance:
                                                Brightness.light,
                                                style: TextStyle(
                                                  fontFamily: kFontPoppins,
                                                  fontSize: 16,
                                                ),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                    'Create new password'),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: 1,
                                          color: HexColor('#707070'),
                                        )
                                      ],
                                    )),
                              ),
                              // repeat password
                              Visibility(
                                visible:visibleEmail,
                                child:Container(
                                    margin: EdgeInsets.only(
                                        left: 30, top: 10, right: 10),
                                    height: 50,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              child: Image.asset(eye),
                                              height: 16,
                                            ),
                                            Container(
                                              width: sizeScreen.width - 130,
                                              padding: EdgeInsets.only(left: 10),
                                              child: TextField(
                                                controller: _ConfirmPassword,
                                                keyboardAppearance:
                                                Brightness.light,
                                                obscureText: true,
                                                style: TextStyle(
                                                  fontFamily: kFontPoppins,
                                                  fontSize: 16,
                                                ),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Repeat password'),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: 1,
                                          color: HexColor('#707070'),
                                        ),
                                      ],
                                    )),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width:150,
                                height:50,
                                decoration:BoxDecoration(
                                  gradient: LinearGradient(
                                      colors:[HexColor('36AFA3'),HexColor('2A8CA2'),HexColor('2274A0')],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30)
                                  ),
                                  boxShadow:[
                                    BoxShadow(
                                      color:HexColor('5D9FFF').withOpacity(0.1),
                                      spreadRadius:5,
                                      offset:Offset(0,3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: FlatButton(
                                  textColor: Colors.white,
                                  child: Text(
                                    'SIGN UP',
                                    style:TextStyle(
                                        color: Colors.white,
                                        fontFamily: kFontRaleway,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    if (visibleMobile) {
                                      if (_Number.text.isEmpty) {
                                        Toast.show(
                                            'Enter Mobile Number',
                                            context,
                                            backgroundColor:Colors.red,
                                            duration:2
                                        );
                                      } else if (_Number.text.length < 8) {
                                        Toast.show(
                                           'Mobile Number should be greater than 8 digits',
                                            context,
                                            backgroundColor:Colors.red,
                                            duration:2
                                        );
                                      } else {
                                        login_signup_OTP();
                                      }
                                    } else if (visibleEmail) {
                                      if (_Email.text.isEmpty) {
                                        Toast.show(
                                            'Enter email id / username',
                                            context,
                                            backgroundColor:Colors.red,
                                            duration:2
                                        );
                                      } else if (_Password.text.isEmpty) {
                                        Toast.show(
                                            'Enter your password',
                                            context,
                                            backgroundColor:Colors.red,
                                            duration:2
                                        );
                                      } else if (_ConfirmPassword.text.isEmpty) {
                                        Toast.show(
                                            'Repeat your password',
                                            context,
                                            backgroundColor:Colors.red,
                                            duration:2
                                        );
                                      } else if (_ConfirmPassword.text != _Password.text) {
                                        Toast.show(
                                            'Repeat password and password are not matching.',
                                            context,
                                            backgroundColor:Colors.red,
                                            duration:2
                                        );
                                      } else {
                                        email_signup();
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Positioned(
                top: 40,
                left: 35,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: HexColor('2DBB54'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )))
          ],
        ));
  }

  void validation(BuildContext context) {
    String email = _Email.text;
    String password = _Password.text;
    String confirmation = _ConfirmPassword.text;
    String mobile = _Number.text;
  }

}

Widget build(BuildContext context) {
  Size sizeScreen = MediaQuery.of(context).size;

  return Scaffold(
    body:Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            bg,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
              child: SafeArea(
            child: FlatButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: SafeArea(
                  child: Container(
                      width: sizeScreen.width - 50,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Already have an account?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            TextSpan(
                                text: ' SIGN IN',
                                style: TextStyle(
                                    fontFamily: kFontPoppins,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 12)),
                          ],
                        ),
                      )),
                )),
          )),
        ),
        Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            reverse: true,
            child: Container(
              height: 400,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 50, right: 50),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 30, top: 40),
                      color: HexColor('#EEF5FF'),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        signBG,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                            height: 90,
                            child: Container(
//                              color:Colors.red,
                              margin: EdgeInsets.only(top: 50),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontFamily: kFontPTSans,
                                    fontSize: 25,
                                    color: Colors.grey),
                              ),
                            )),
                        SizedBox(
                            height: 8,
                            width: 95,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: HexColor('#5D9FFF'),
                                  borderRadius: BorderRadius.circular(4)),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(left: 30, top: 10, right: 30),
                            height: 50,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Image.asset(user),
                                      height: 20,
                                    ),
                                    Container(
                                      width: sizeScreen.width - 185,
                                      padding: EdgeInsets.only(left: 10),
                                      child: TextField(
                                        keyboardAppearance: Brightness.light,
                                        style: TextStyle(
                                          fontFamily: kFontPoppins,
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Email ID / username'),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  color: HexColor('#707070'),
                                )
                              ],
                            )),
                        Container(
                            margin:
                                EdgeInsets.only(left: 30, top: 10, right: 30),
                            height: 50,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Image.asset(eye),
                                      height: 16,
                                    ),
                                    Container(
                                      width: sizeScreen.width - 185,
                                      padding: EdgeInsets.only(left: 10),
                                      child: TextField(
                                        obscureText: true,
                                        keyboardAppearance: Brightness.light,
                                        style: TextStyle(
                                          fontFamily: kFontPoppins,
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Create new password'),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  color: HexColor('#707070'),
                                )
                              ],
                            )),
                        Container(
                            margin:
                                EdgeInsets.only(left: 30, top: 10, right: 30),
                            height: 50,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Image.asset(eye),
                                      height: 16,
                                    ),
                                    Container(
                                      width: sizeScreen.width - 185,
                                      padding: EdgeInsets.only(left: 10),
                                      child: TextField(
                                        keyboardAppearance: Brightness.light,
                                        obscureText: true,
                                        style: TextStyle(
                                          fontFamily: kFontPoppins,
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Repeat password'),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  color: HexColor('#707070'),
                                ),
                              ],
                            )),
                        Container(
                            width: sizeScreen.width,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 30, top: 30),
                            child: CircleAvatar(
                                backgroundColor: HexColor('36AFA3'),
                                radius: 22,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                )))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
