import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:phillshoes/Views/Rating.dart';


class ShareTheOTP extends StatefulWidget {
  @override
  _ShareTheOTPState createState() => _ShareTheOTPState();
}

class _ShareTheOTPState extends State<ShareTheOTP> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer(Duration(seconds:2), () {
        Future.delayed (const Duration(milliseconds:300), () {
          setState(() {
            showDialog(context);

            Timer(Duration(seconds:2), () {
              Future.delayed (const Duration(milliseconds:300), () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Rating()));
                });
              });
            });
          });
        });
      });
    });
  }

  Future<void> showDialog(BuildContext context) async {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible:false,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: Duration(milliseconds:300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
            alignment:Alignment.bottomCenter,
            child:Material(
              color:Colors.transparent,
              child:GestureDetector(
                child:Container(
                  height:300,
                  margin:EdgeInsets.only(bottom:0, left:0, right:0),
                  child:Stack(
                    children: <Widget>[
                      Container(
                        width:MediaQuery.of(context).size.width,
                        decoration:BoxDecoration(
                          image:DecorationImage(
                            image:AssetImage(
                              bgHalf,
                            ),
                            fit: BoxFit.cover,
                          ),
                          color:Colors.red,
                          borderRadius:BorderRadius.only(topRight:Radius.circular(30),topLeft:Radius.circular(30)),
                        ),
                      ),
                      Positioned(
                        top:0,
                        bottom:0,
                        left:0,
                        right:0,
                        child:Column(
                          children: <Widget>[
                            Container(
                              child:Text(
                                  'Share the OTP to complete',
                                  style:TextStyle(
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w300,
                                      color:Colors.white,
                                      fontSize:20)
                              ),
                              margin:EdgeInsets.only(top:30),
                            ),
                            Container(
                              child:Text(
                                  'the task',
                                  style:TextStyle(
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w300,
                                      color:Colors.white,
                                      fontSize:20)
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom:0,
                        left:0,
                        right:0,
                        child:Container(
                          margin:EdgeInsets.only(bottom:20),
                          child:Text(
                              'Refresh the OTP',
                              textAlign:TextAlign.center,
                              style:TextStyle(
                                  fontFamily:kFontPoppins,
                                  fontWeight:FontWeight.w300,
                                  color:Colors.white,
                                  fontSize:10)
                          ),
                        ),
                      ),
                      Center(
                        child:Text(
                            '543 443 754 421',
                            textAlign:TextAlign.center,
                            style:TextStyle(
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w500,
                                color:Colors.white,
                                fontSize:20)
                        ),
                      )
                    ],
                  ),
                ),
                onTap:() {
                  Navigator.pop(context);
                },
              )
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

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:Colors.white,
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar( // Here we create one to set status bar color
            backgroundColor: Colors.white,
            elevation:0,
            brightness:Brightness.light,// Set any color of status bar you want; or it defaults to your theme's primary color
          )
      ),
      body:Stack(
        children: <Widget>[
          Positioned(
            left:30,
            top:30,
            child:SafeArea(
                child:Row(
                  children: <Widget>[
                    Container(
                      height:60,
                      width:60,
//                      margin:EdgeInsets.only(top:13,left:16),
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
                      child:CircleAvatar(
                        radius: 50,
                        backgroundColor:HexColor('78B6FA'),
                        child:IconButton(
                            icon:Icon(
                              Icons.arrow_back,
                              color:Colors.white,
                            ),
                            onPressed:() {
                              Navigator.pop(context);
//                            showDialog(context);
                            }),
                      ),
                    ),
                    Container(
                      margin:EdgeInsets.only(left:30,right:30),
                      width:sizeScreen.width,
                      child:Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: sizeScreen.width - 50,
                              child: RichText(
                                textAlign: TextAlign.left,
                                text:
                                TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Veer,',
                                        style:TextStyle(
                                            fontFamily:kFontPoppins,
                                            fontWeight:FontWeight.w600,
                                            color:HexColor('2DBB54'),
                                            fontSize:14)
                                    ),
                                    TextSpan(
                                        text: ' has completed the task',
                                        style: TextStyle(
                                            fontFamily:kFontPoppins,
                                            fontWeight:FontWeight.normal,
                                            color: Colors.black,
                                            fontSize: 14
                                        )
                                    ),
                                  ],
                                ),
                              )
                          ),
                          Text(
                            'Share the OTP ',
                            style:TextStyle(
                                color:Colors.black,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w600,
                                fontSize:20
                            ),
                            maxLines:2,
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
          Center(
            child:Container(
              height:160,
              width:160,
              padding:EdgeInsets.all(30),
              child:Image.asset(
                tick,
              ),
            ),
          ),
        ],
      ),
    );

  }
}


