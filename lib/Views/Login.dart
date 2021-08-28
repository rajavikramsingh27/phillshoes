
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:flutter/services.dart';
import 'package:stretchy_header/stretchy_header.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/OTP.dart';
import 'package:phillshoes/Views/SignUp.dart';
import 'package:phillshoes/Views/Password.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:toast/toast.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    kIsSignUp = false;
    super.initState();
  }

  bool isNumeric(String str) {
    return RegExp(r'^-?[0-9]+$').hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    login_signup_OTP() async {
      try {
        var url = kBaseURL+'login_signup_OTP';
        print(url);
        var param = {
          'user_role': kType,
          'user_mobile': textController.text
        };
        print(param);

        showLoading(context);
        var response = await http.post(url, body:param);
        dismissLoading(context);

        Map<String, dynamic> toJson = json.decode(response.body);
        print(toJson);

//        if (toJson[kstatus] == ksuccess) {
//          SharedPreferences prefs = await SharedPreferences.getInstance();
//          prefs.setString(kUserDetails,response.body);
//          print(prefs.get(kUserDetails));
//          Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => OTP()));
//        } else {
//          Toast.show(
//              toJson[kmessage].toString(),
//              context,
//              backgroundColor:Colors.red,
//              duration:2
//          );
//        }
      } catch (error) {
        print(error.toString());
      }
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
                            'Hello, nice to meet you!',
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
                            'Get moving with our services',
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
                      padding:EdgeInsets.only(left:30,right:30),
                      child:Container(
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
                        child:Row(
                          children: <Widget>[
                            Container(
                              margin:EdgeInsets.only(left: 30),
                              width:20,
                              alignment:Alignment.centerRight,
                              padding:EdgeInsets.only(right:0),
                              child:Image.asset(user),
                            ),
                            Container(
                              width:sizeScreen.width - 120,
                              padding:EdgeInsets.only(left:16),
                              child:TextField(
                                keyboardType:TextInputType.emailAddress,
                                controller:textController,
                                keyboardAppearance:Brightness.light,
                                style:TextStyle(
                                  fontFamily:kFontPoppins,
                                  fontSize:16,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:'Email ID/ Number'
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height:20,),
                    Container(
                        width:sizeScreen.width,
                        height:40,
                        alignment:Alignment.centerRight,
                        padding:EdgeInsets.only(right:30),
                        child:CircleAvatar(
                            backgroundColor:HexColor('41CEA4'),
                            child:IconButton(
                              icon:Icon(
                                Icons.arrow_forward,
                                color:Colors.white,
                              ),
                              onPressed:() {
                                email = textController.text;
                                if (textController.text.isNotEmpty) {
                                  bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                      .hasMatch(email);
                                  if (textController.text.isNotEmpty || isNumeric(email)) {
                                    if (isNumeric(textController.text)) {
                                      login_signup_OTP();
                                    } else {
                                      email = textController.text;
                                      if (emailValid) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Password()));
                                      } else {
                                        Toast.show(
                                            'Enter valid email ID',
                                            context,
                                            backgroundColor:Colors.red,
                                            duration:2
                                        );
                                      }
                                    }
                                  }
                                }
                              },
                            )
                        )
                    ),
                    SizedBox(height:10,),
                    Container(
                        width:sizeScreen.width,
                        height:20,
                        margin:EdgeInsets.only(left:30),
                        child:Row(
                          children:<Widget>[
                            Text(
                                "Don't have an account ? ",
                                style:TextStyle(
//                                  fontWeight:FontWeight.w500,
                                    fontFamily:kFontPoppins,
                                    color:Colors.black,
                                    fontSize:12
                                )
                            ),
                            ButtonTheme(
                              minWidth:50.0,
                              child:FlatButton(
                                padding:EdgeInsets.all(0),
                                textColor:Colors.white,
                                child:Text(
                                    'SIGN UP',
                                    textAlign:TextAlign.left,
                                    style:TextStyle(
                                        fontWeight:FontWeight.w600,
                                        fontFamily:kFontPoppins,
                                        color:Colors.black,
                                        fontSize:12
                                    )
                                ),
                                onPressed:() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUp()));
                                },
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(height:50,),
                    Container(
                        width: sizeScreen.width - 50,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'By creating an account, you agree to our \n',
                                  style:TextStyle(
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

