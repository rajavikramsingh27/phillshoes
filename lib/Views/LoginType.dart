import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:flutter/services.dart';
import 'package:stretchy_header/stretchy_header.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phillshoes/Views/Dashboard.dart';
import 'package:phillshoes/ViewService/DashboardService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'dart:async';


class LoginTypes extends StatefulWidget {
  @override
  _LoginTypesState createState() => _LoginTypesState();
}



class _LoginTypesState extends State<LoginTypes> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = Firestore.instance;


  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      update_service();
    });
    // TODO: implement initState
    super.initState();
  }

  update_service() async {
    await _auth.currentUser().then((currentUser) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      kType = prefs.getString(kType);
      print(kType);

      kType = prefs.getString(kType);
      print(kType);

      String fireBaseStorage = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
      fireStore.collection(fireBaseStorage).document(currentUser.email+kConnect+currentUser.uid).get().then((value) {
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
      });
    });

  }

    @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body:StretchyHeader.singleChild(
        headerData:HeaderData(
          headerHeight:350,
          header:Container(
            alignment:Alignment.center,
            child:Stack(
              children: <Widget>[
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
                )
              ],
            ),
          ),
        ),
        child:Container(
          height:400,
          child:Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                    child:ClipRect(
                      child:BackdropFilter(
                        filter:ImageFilter.blur(sigmaX:0.0, sigmaY:0.0),
                        child:Container(
                          margin:EdgeInsets.only(top:20),
                          width:sizeScreen.width,
                          height:270,
                          decoration:BoxDecoration(
                              color:Colors.grey.withOpacity(0.03),
                              borderRadius:BorderRadius.circular(70)
                          ),
                          child:Column(
                            children: <Widget>[
                              Container(
                                width: sizeScreen.width,
                                height:100,
                                margin:EdgeInsets.only(top: 20),
                                child:Stack(
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'You are:',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:kFontRaleway,
                                              fontSize:25,
                                              fontWeight: FontWeight.w700
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              Stack(children: <Widget>[
                                Center(
                                  child: Container(
                                    width:190,
                                    height:50,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                            colors:[HexColor('36AFA3'),HexColor('2A8CA2'),HexColor('2274A0')],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter
                                        ),
                                      borderRadius: BorderRadius.all(
                                            Radius.circular(30)
                                        ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:HexColor('5D9FFF').withOpacity(0.1),
                                          spreadRadius:5,
                                          offset:Offset(0,3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(child: SizedBox(
                                  height:50,
                                  width:190,
                                  child:FlatButton(
                                    textColor: Colors.white,
                                    child:Text(
                                      'Service Provider',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:kFontRaleway,
                                          fontSize:16,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    onPressed:() {
                                      kType = kService;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Login()));
                                    },
                                  ),
                                ),)
                              ],),
                              SizedBox(height: 20,),
                              Stack(children: <Widget>[
                                Center(
                                  child: Container(
                                    width:190,
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
                                  ),
                                ),
                                Center(child: SizedBox(
                                  height:50,
                                  width:190,
                                  child:FlatButton(
                                    textColor: Colors.white,
                                    child:Text(
                                      'User',
                                      style:TextStyle(
                                          color:Colors.white,
                                          fontFamily:kFontRaleway,
                                          fontSize:16,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    onPressed:() {
                                      kType = kUser;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Login()));
                                    },
                                  ),
                                ),)
                              ],),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:30,),
              Container(
                  width: sizeScreen.width - 50,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'By creating an account, you agree to our \n',
                            style:TextStyle(
//                                fontWeight:FontWeight.w500,
                                fontFamily:kFontPoppins,
                                color:Colors.black,
                                fontSize:12
                            )
                        ),
                        TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                                fontFamily:kFontPoppins,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 12)
                        ),
                        TextSpan(
                            text: ' and ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12)
                        ),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                fontFamily:kFontPoppins,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize:12)
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height:30,),
            ],
          )
        )
      ),
    );
  }
}