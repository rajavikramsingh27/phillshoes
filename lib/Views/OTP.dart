

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:flutter/services.dart';
import 'package:stretchy_header/stretchy_header.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:phillshoes/Views/Dashboard.dart';
import 'package:phillshoes/ViewService/DashboardService.dart';
import 'package:phillshoes/ViewService/SelectAnOption.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';


class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}



class _OTPState extends State<OTP> {
  var otp = '';

  verify_OTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails = json.decode(prefs.get(kUserDetails));
    List<Map<String, dynamic>> arrResult = List<Map<String, dynamic>>.from(userDetails['kresult']);
//    print(arrResult[0]['id']);

    var url = kBaseURL+'verify_OTP';
//    print(url);

    var param = {
      'user_id':arrResult[0]['id'],
      'otp':otp
    };
//    print(param);

    showLoading(context);
    var response = await http.post(url, body:param);
    dismissLoading(context);

    Map<String, dynamic> toJson = json.decode(response.body);

    Toast.show(
        toJson['kmessage'].toString(),
        context,
        backgroundColor:Colors.red,
        duration:2
    );

    if (toJson['kstatus'] == 'ksuccess') {
      if (kIsSignUp) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectAnOption()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardService()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    CircleAvatar circleAvtar(Color backgroundColor) {
      print(otp.length);
      return CircleAvatar(
          backgroundColor: otp.length == 6 ? HexColor('41CEA4') : HexColor('D6D6D6'),
          child:IconButton(
            icon:Icon(
              Icons.arrow_forward,
              color:Colors.white,
            ),
            onPressed:() {
              if (kType == kUser) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              } else {
                if (otp.isNotEmpty && otp.length > 5) {
                  verify_OTP();
                }
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
                            height:30,
                            width:sizeScreen.width,
                            padding:EdgeInsets.only(left:30,right:30),
                            child:Text(
                              'Phone/Email Verification',
                              textAlign:TextAlign.left,
                              style:TextStyle(
                                  fontFamily:kFontPoppins,
                                  fontSize:12
                              ),
                            ),
                          ),
                          Container(
                            width:sizeScreen.width,
                            padding:EdgeInsets.only(left:30,right:30),
                            child:Text(
                              'Enter your OTP code below',
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
                              child:OTPTextField(
                                obscureText:true,
                                length:6,
                                width:MediaQuery.of(context).size.width,
                                fieldWidth:20,
                                style:TextStyle(
                                    fontSize: 17
                                ),
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                fieldStyle:FieldStyle.underline,
                                onChanged:(pin) {
                                  print(pin);
                                  pin.length < 4 ? circleAvtar(HexColor('D6D6D6')) : circleAvtar(HexColor('41CEA4'));
                                  setState(() {
                                    otp = pin;
                                  });
                                },
                                onCompleted:(pin) {
                                  print("Completed: " + pin);
                                },
                              ),
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
                      Container(
                          width:sizeScreen.width - 60,
                          child:RichText(
                            textAlign:TextAlign.left,
                            text:TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Resend Code in ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12)
                                ),
                                TextSpan(
                                    text: '10 seconds',
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
                      SizedBox(height:60,),
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
