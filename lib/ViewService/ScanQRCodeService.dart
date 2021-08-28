
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/ViewService/PlaceService.dart';
import 'dart:async';


class ScanQRCodeService extends StatefulWidget {
  @override
  _ScanQRCodeServiceState createState() => _ScanQRCodeServiceState();
}

class _ScanQRCodeServiceState extends State<ScanQRCodeService> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds:2), () {
      Future.delayed (const Duration(milliseconds: 500), () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceService()));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:Colors.white,
      appBar: PreferredSize(
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
                                        text: 'Mark,',
                                        style:TextStyle(
                                            fontFamily:kFontPoppins,
                                            fontWeight:FontWeight.w600,
                                            color:HexColor('2DBB54'),
                                            fontSize:14)
                                    ),
                                    TextSpan(
                                        text: ' your are at your place',
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
                            'Scan the QR code',
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
          Positioned(
            bottom:10,
            child:SafeArea(
                child:Container(
                    width:sizeScreen.width,
                    child:Column(
                      children: <Widget>[
                        Container(
                          padding:EdgeInsets.all(5),
                          height:50,
                          decoration:BoxDecoration(
                              color:Colors.white,
                              border:Border.all(
                                  color:HexColor('#78B6FA'),
                                  width:3.5
                              ),
                              borderRadius:BorderRadius.circular(7)
                          ),
                          child:Image.asset(
                            QR_code,
                          ),
                        ),
                        SizedBox(height:20,),
                        Text(
                            'Refresh the scan',
                            textAlign:TextAlign.center,
                            style: TextStyle(
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w400,
                                color: Colors.black,
                                fontSize:14
                            )
                        ),
                      ],
                    )
                )
            ),
          ),
          Center(
            child:Container(
              height:280,
              width:280,
              padding:EdgeInsets.all(30),
              decoration:BoxDecoration(
                color:Colors.white,
                border:Border.all(
                  color:HexColor('707070'),
                ),
                borderRadius:BorderRadius.circular(85),
              ),
              child:Container(
                padding:EdgeInsets.all(25),
                height:65,
                decoration:BoxDecoration(
                    color:Colors.white,
                    border:Border.all(
                        color:HexColor('#78B6FA'),
                        width:14
                    ),
                    borderRadius:BorderRadius.circular(46)
                ),
                child:Image.asset(
                  QR_code,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

