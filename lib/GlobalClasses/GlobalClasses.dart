import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

_launchURL() async {
  const url = 'https://flutter.dev';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String nanosecondsParam() {
    Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now()); //To TimeStamp
    return myTimeStamp.nanoseconds.toString();
}

BoxShadow setShadow() {
  return BoxShadow(
    color:Colors.grey.withOpacity(0.1),
    spreadRadius:2,
    blurRadius:2,
    offset: Offset(0,3),
  );
}

PreferredSize setAppBar() {
  return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child:AppBar( // Here we create one to set status bar color
        backgroundColor: Colors.white,
        elevation:0,
        brightness:Brightness.light,// Set any color of status bar you want; or it defaults to your theme's primary color
      )
  );
}

setNoti_Booking_CurrentUser(BuildContext context, String title, String message, Map<String, dynamic> dataNotiReciever,Map<String, dynamic> bookingDetails, String deviceToken) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = Firestore.instance;

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



setNoti_Booking_RecieverUser(BuildContext context, String title, String message, Map<String, dynamic> dataNotiReciever,Map<String, dynamic> bookingDetails, String deviceToken) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = Firestore.instance;

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

sendNotification(String title, String message, String deviceToken) async {
//  print(deviceToken);
//  print(kFireBaseServerkey);

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
            'data':'Rejected',
            'to':'dnPodjl_NpA:APA91bFfNQYaJlicqEto_G1SYTsef6APQr6q04fRpoDFPEsv8An3BrqMeA8J9zgPuv9B52GDo00IyojlM9M_9ecqbV6OrvE46EkfSbzqvfl1q8zUYq5_57abRs-lFCoCk-6LW2dbAqeM',
          })
  );
}

void showLoading(BuildContext context) {
  showDialog(
    context:context,
    barrierDismissible:false,
    builder: (BuildContext context) {
      return Dialog(
          child:Container(
            height:80,
            padding:EdgeInsets.only(left:16,right:16),
            child:Row(
              children: [
                CircularProgressIndicator(
                  backgroundColor:HexColor(kThemeColor),
                ),
                SizedBox(width:20),
                Text(
                  'Loading...',
                  style: TextStyle(
                      color:Colors.grey,
                      fontFamily:kFontRaleway,
                      fontSize:18,
                      fontWeight:FontWeight.w400),
                ),
              ],
            ),
          )
      );
    },
  );

}

void dismissLoading(BuildContext context) {
  Navigator.pop(context);
}


