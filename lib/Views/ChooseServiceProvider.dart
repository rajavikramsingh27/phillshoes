import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/Notifications.dart';
import 'package:phillshoes/Views/ServiceExtension.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:phillshoes/ViewService/Location.dart';
import 'package:url_launcher/url_launcher.dart';



class ChooseServiceProvider extends StatefulWidget {
  @override
  _ChooseServiceProviderState createState() => _ChooseServiceProviderState();
}

class _ChooseServiceProviderState extends State<ChooseServiceProvider> {
  List<Map<String, dynamic>> arrServiceProvider = [];

  final fireStore = Firestore.instance;
  var storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      find_provider();
    });
    super.initState();
  }

  find_provider() async {
    showLoading(context);
    QuerySnapshot querySnapshot = await fireStore.collection(kFireBaseServiceProviders).getDocuments();
    arrServiceProvider = querySnapshot.documents.map((DocumentSnapshot doc) {
      print('object');
      return doc.data;
    }).toList();
    dismissLoading(context);

    setState(() {
      print('objectobjectobjectobject');
    });
  }

  /*
  setNoti_Booking_CurrentUser(String title, String message, Map<String, dynamic> dataNotiReciever,Map<String, dynamic> bookingDetails, String deviceToken) async {
    await _auth.currentUser().then((currentUser) async {
      String fireBaseStorage = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
      fireStore.collection(fireBaseStorage).document(currentUser.email+kConnect+currentUser.uid).get().then((value) async {
        var myUserDetails = value.data;

        myUserDetails[kTitle_Notification] = title;
        myUserDetails[kMessage_Notification] = message;

        Map<String, dynamic> dictNoti_BookingDetails = bookingDetails;
        dictNoti_BookingDetails[kServiceProviderDetails] = myUserDetails;
        dictNoti_BookingDetails[kUserDetails] = dataNotiReciever;

        await http.post(
            'https://fcm.googleapis.com/fcm/send',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'key=$kFireBaseServerkey',
            },
            body:jsonEncode(
                <String, dynamic>{
                  'notification':<String, dynamic>{
                    'body':message,
                    'title':title
                  },
                  'priority':'high',
                  'data':dictNoti_BookingDetails,
                  'to':deviceToken,
                })
        );

        fireStore.collection(kFireBaseNotifications).document(dataNotiReciever[kemail_ID]+kConnect+dataNotiReciever[kuserID]).
        collection(bookingDetails[kBookingID]).document(bookingDetails[kBookingID]).setData(
            dictNoti_BookingDetails
        ).catchError((error) {
          Toast.show(
              error.toString(),
              context,
              backgroundColor:Colors.red,
              duration:2
          );
        }).then((value) async {

        });
      }).catchError((error) {
        print(error.toString());
      });
    });

  }

  setNoti_Booking_RecieverUser(String title, String message, Map<String, dynamic> dataNotiReciever,Map<String, dynamic> bookingDetails, String deviceToken) async {
    await _auth.currentUser().then((currentUser) async {
      Map<String, dynamic> dictNoti_BookingDetails = {};
      String fireBaseStorage = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
      fireStore.collection(fireBaseStorage).document(currentUser.email+kConnect+currentUser.uid).get().then((value) async {
        var myUserDetails = value.data;
        myUserDetails[kTitle_Notification] = title;
        myUserDetails[kMessage_Notification] = message;

        dictNoti_BookingDetails = bookingDetails;
        dictNoti_BookingDetails[kServiceProviderDetails] = dataNotiReciever;
        dictNoti_BookingDetails[kUserDetails] = myUserDetails;

        await http.post(
            'https://fcm.googleapis.com/fcm/send',
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'key=$kFireBaseServerkey',
            },
            body:jsonEncode(
                <String, dynamic>{
                  'notification':<String, dynamic>{
                    'body':message,
                    'title':title
                  },
                  'priority':'high',
                  'data':dictNoti_BookingDetails,
                  'to':deviceToken,
                })
        );

        fireStore.collection(kFireBaseNotifications).document(currentUser.email+kConnect+currentUser.uid).
        collection(bookingDetails[kBookingID]).document(bookingDetails[kBookingID]).setData(
            dictNoti_BookingDetails
        ).catchError((error) {
          print(error.toString());
          Toast.show(
              error.toString(),
              context,
              backgroundColor:Colors.red,
              duration:2
          );
        }).then((value) async {

        });
      }).catchError((error) {
        print(error.toString());
      });
    });

  }
  */

  send_FCM_Notifications(String title, String message, Map<String, dynamic> dataNotifications, String deviceToken) async {
     final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

     await firebaseMessaging.requestNotificationPermissions(
       const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
     );

     final bookingID = nanosecondsParam();
     Map<String, dynamic> dictBookingDetails = {};
     dictBookingDetails[kBookingID] = bookingID;
     dictBookingDetails[klocal_address] = dictDestination[klocal_address];
     dictBookingDetails[klatitude] = dictDestination[klatitude];
     dictBookingDetails[klongitude] = dictDestination[klongitude];
     dictBookingDetails[kStatusBooking] = kStatusBookingInComing;

//     print(dictBookingDetails);

     setNoti_Booking_CurrentUser(context, title, message, dataNotifications, dictBookingDetails, deviceToken);
     setNoti_Booking_RecieverUser(context, title, message, dataNotifications, dictBookingDetails, deviceToken);

//     setNoti_Booking_CurrentUser(title, message, dataNotifications,dictBookingDetails,deviceToken);
//     setNoti_Booking_RecieverUser(title, message, dataNotifications,dictBookingDetails,deviceToken);
  }

  @override
  Widget build(BuildContext context) {

    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      body:Stack(
        children: <Widget>[
          Positioned(
            left:0,
            right:0,
            top:0,
            child:Container(
              height:330,
              child:Image.asset(curveBG,fit:BoxFit.fill),
            ),
          ),
          Positioned(
            top:0,
            bottom:0,
            left:0,
            right:0,
              child:SafeArea(
                  child:Container(
                      child:Container(
                        height:222,
                        child:ListView.builder(
                          scrollDirection:Axis.vertical,
                          itemCount:arrServiceProvider.length+1,
                          itemBuilder:(context, index) {
                            if ( index == 0 ) {
                              return Container(
                                height:180,
                                margin:EdgeInsets.only(left:16,right:16,bottom:8,top:8),
                                child:Column(
                                  children:<Widget>[
                                    SafeArea(
                                        child:Container(
                                          width:sizeScreen.width,
                                          padding:EdgeInsets.only(right:15),
                                          alignment:Alignment.centerRight,
                                          child:CircleAvatar(
                                              radius:20,
                                              backgroundColor:Colors.white,
                                              child:IconButton(
                                                icon:Icon(
                                                  Icons.notifications_none,
                                                  color:HexColor('C3CDD6'),
                                                ),
                                                onPressed:() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => Notifications()));
                                                },
                                              )
                                          ),
                                        )
                                    ),
                                    Container(
                                        child:Row(
                                          children: <Widget>[
                                            Container(
                                              child:CircleAvatar(
                                                  radius:25,
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
                                              ),
                                              margin:EdgeInsets.only(left:36),
                                            ),
                                            Container(
                                              margin:EdgeInsets.only(left:30,right:30),
                                              width:sizeScreen.width-180,
                                              child:Text(
                                                'Choose Service Provider',
                                                style:TextStyle(
                                                    color:Colors.white,
                                                    fontFamily:kFontPoppins,
                                                    fontWeight:FontWeight.w600,
                                                    fontSize:20
                                                ),
                                                maxLines:2,
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return GestureDetector(
                                child:Container(
                                  child:Container(
                                      height:140,
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
                                                child:ClipRRect(
                                                  child:FadeInImage(
                                                    height:44,
                                                    width:44,
                                                    image:NetworkImage(
                                                        arrServiceProvider[index-1][kprofile]
                                                    ),
                                                    placeholder:AssetImage(userPerson),
                                                  ),
                                                  borderRadius:BorderRadius.circular(50),
                                                ),
                                                height:60,
                                                width:60,
                                                margin:EdgeInsets.only(top:24,left:24),
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
                                              Container(
                                                margin:EdgeInsets.only(left:24,top:16),
                                                child:Text(
                                                  arrServiceProvider[index-1][kname],
                                                  style:TextStyle(
                                                      fontFamily:kFontPoppins,
                                                      fontSize:15,
                                                      fontWeight:FontWeight.w600
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width:sizeScreen.width-270,
                                                margin:EdgeInsets.only(left:10,top:20),
                                                alignment:Alignment.centerLeft,
                                                child:Text(
                                                  (arrServiceProvider[index-1][kservice_name] == null)
                                                      ? 'Service name'
                                                      : arrServiceProvider[index-1][kservice_name],
                                                  style:TextStyle(
                                                      fontFamily:kFontPoppins,
                                                      fontSize:16,
                                                      fontWeight:FontWeight.w600
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:EdgeInsets.only(left:10,right:10),
                                                width:sizeScreen.width-270,
                                                child:Text(
                                                  'Online 15 minutes ago',
                                                  style:TextStyle(
                                                      color:HexColor('D6D6D6'),
                                                      fontFamily:kFontPoppins,
                                                      fontSize:11,
                                                      fontWeight:FontWeight.w600
                                                  ),
                                                  maxLines:2,
                                                ),
                                              ),
                                              Container(
                                                  margin:EdgeInsets.only(left:10,top:3),
                                                  child:Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.star_border,
                                                        color:HexColor('36AEA3'),
                                                        size:22,
                                                      ),
                                                      Text(
                                                        '4.5 / 5',
                                                        style:TextStyle(
                                                            color:HexColor('D6D6D6'),
                                                            fontFamily:kFontPoppins,
                                                            fontSize:11,
                                                            fontWeight:FontWeight.w600
                                                        ),
                                                        maxLines:2,
                                                      )
                                                    ],
                                                  )
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment:Alignment.bottomRight,
                                            margin:EdgeInsets.only(right:0),
                                            child:Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      'Request',
                                                      style:TextStyle(
                                                          color:Colors.black,
                                                          fontFamily:kFontPoppins,
                                                          fontSize:13,
                                                          fontWeight:FontWeight.w600
                                                      ),
                                                      maxLines:2,
                                                    ),
                                                    SizedBox(width:10,),
                                                    CircleAvatar(
                                                      radius:15,
                                                      backgroundColor:HexColor('35ADA3'),
                                                      child:Icon(Icons.arrow_forward,size:17,),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height:13),
                                                FlatButton(
                                                  padding:EdgeInsets.only(left:0),
                                                  child:Container(
                                                    alignment:Alignment.centerRight,
                                                    width:90,
                                                    child:Row(
                                                      mainAxisAlignment:MainAxisAlignment.end,
                                                      children:<Widget>[
                                                        Text(
                                                          'Call',
                                                          style:TextStyle(
                                                              color:Colors.black,
                                                              fontFamily:kFontPoppins,
                                                              fontSize:13,
                                                              fontWeight:FontWeight.w600
                                                          ),
                                                          maxLines:2,
                                                        ),
                                                        SizedBox(width:10,),
                                                        CircleAvatar(
                                                          radius:15,
                                                          backgroundColor:HexColor('#B9C0C0'),
                                                          child:Icon(
                                                            Icons.call,
                                                            size:17,
                                                            color:Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onPressed:() {
                                                    print(arrServiceProvider[index-1][kmobile]);
                                                    if (arrServiceProvider[index-1][kmobile].toString().isEmpty) {
                                                      Toast.show(
                                                          'Phone number is not updated',
                                                          context,
                                                          backgroundColor:Colors.red,
                                                          duration:2
                                                      );
                                                    } else {
                                                      launch("tel://"+arrServiceProvider[index-1][kmobile]);
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                onTap:() {
//                                  Notifications
                                 var dataNotifications = arrServiceProvider[index-1];
                                 var deviceToken = dataNotifications[kdevice_token];

                                 send_FCM_Notifications(kBookingIsIncoming, kCheckYourApp, dataNotifications, deviceToken);

//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(builder: (context) => ServiceExtension()));
                                },
                              );
                            }
                          },
                        ),
                      )
                  )
              ),
          ),
        ]
      )
    );
  }
}


