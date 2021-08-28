import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:io';
import 'package:phillshoes/Views/LoginType.dart';
import 'package:flutter/services.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:intl/intl.dart';

//Plugin project :firebase_core_web not found. Please update settings.gradle.
//Plugin project :location_web not found. Please update settings.gradle.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  @override
  void initState() {
    Future.delayed(Duration(seconds:1), () {
      _saveDeviceToken();

      if (Platform.isIOS) {
        iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {

        });
        _fcm.requestNotificationPermissions(IosNotificationSettings());
      }

      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage:--------------------------------"
              "\n------------------------------------------------"
              "\n-------------------------------------------------\n"
              "\n---------------------------------------------------------------"
              " $message");

          final dictData = Map<String, dynamic>.from(message['data']);
          final dictNotification = Map<String, dynamic>.from(message['notification']);
          final title = dictNotification['title'];

          if (title == kBookingIsIncoming) {
            DartNotificationCenter.post(channel:kBookingIsIncoming, options:dictData,);
          }

        },

        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          // TODO optional
        },

        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // TODO optional
        },
      );
    });
  }



  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    fcmToken = await _fcm.getToken();
    print(fcmToken);
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:LoginTypes(),
//      home:SelectAnOption(),
      debugShowCheckedModeBanner:false,
      routes: {
//        'LoginTypes':(context) => LoginTypes(),
//        'ProfileService':(context) => ProfileService(),
      },
    );
  }
}
