import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Map<String, dynamic>> arrNotifications = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      get_notification();
    });

    super.initState();
  }

  get_notification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails = json.decode(prefs.get(kUserDetails));
    List<Map<String, dynamic>> arrUserDetails = List<Map<String, dynamic>>.from(userDetails['kresult']);

    var url = kBaseURL+'get_notification';

    var param = {
      'user_id':'2',
      //      'user_id':arrUserDetails[0]['id'],
    };
    print(param);

    showLoading(context);
    var response = await http.post(url, body:param);
    dismissLoading(context);

    Map<String, dynamic> toJson = json.decode(response.body);

    if (toJson['kstatus'] == 'ksuccess') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kUserDetails,response.body);
      arrNotifications = List<Map<String, dynamic>>.from(toJson['kresult']);

      setState(() {

      });
    } else {
      Toast.show(
          toJson['kmessage'].toString(),
          context,
          backgroundColor:Colors.red,
          duration:2
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      body:Stack(
        children: <Widget>[
          Positioned(
              top:0,
              bottom:0,
              left:0,
              right:0,
              child:Image.asset(
                bg,
                fit:BoxFit.fill,
              )
          ),
          Positioned(
              top:0,
              left:30,
              right:0,
              child:SafeArea(
                child:Container(
                  height:50,
                  alignment:Alignment.centerLeft,
                  child:CircleAvatar(
                    radius:25,
                    backgroundColor:Colors.white,
                    child:IconButton(
                        icon:Icon(
                          Icons.arrow_back,
                          size:25,
                          color:HexColor('2DBB54'),
                        ),
                        onPressed:() {
                          Navigator.pop(context);
                        }
                    ),
                  ),
                ),
              )
          ),
          Positioned(
            top:60+MediaQuery.of(context).padding.top,
            left:0,
            right:0,
            bottom:0,
              child:ListView.builder(
                padding: EdgeInsets.all(0.0),
                scrollDirection:Axis.vertical,
                itemCount:arrNotifications.length,
                itemBuilder:(context, index) {
                  return Container(
                      height:90,
                      margin:EdgeInsets.only(left:30,right:30,top:6,bottom:6),
                      decoration:BoxDecoration(
                          color:Colors.white,
                          borderRadius:BorderRadius.circular(12),
                          border:Border.all(
                              color:Colors.grey,
                              width:1
                          )
                      ),
                      child:Row(
                        children:<Widget>[
                          Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child:CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(userPerson),
                                ),
                                height:60,
                                width:60,
                                margin:EdgeInsets.only(top:13,left:24),
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
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
//                                color:Colors.red,
                                width:sizeScreen.width-160,
                                margin:EdgeInsets.only(left:10),
                                alignment:Alignment.centerLeft,
                                child:Text(
                                  arrNotifications[index]['title'],
                                  style:TextStyle(
                                      fontFamily:kFontPoppins,
                                      fontSize:14,
                                      fontWeight:FontWeight.w600
                                  ),
                                ),
                              ),
                              Container(
//                                color:Colors.red,
                                padding:EdgeInsets.only(left:0),
                                width:sizeScreen.width-160,
                                child:Text(
                                    arrNotifications[index]['created'],
                                  style:TextStyle(
                                      color:HexColor('D6D6D6'),
                                      fontFamily:kFontPoppins,
                                      fontSize:12,
                                      fontWeight:FontWeight.w600
                                  ),
                                  maxLines:2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  );
                },
              ),
          )
        ],
      ),
    );
  }
}

