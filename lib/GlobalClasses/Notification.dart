import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Notification {
  static Notification sharedInstance = Notification();

  static sendFcmMessage(String title, String message,Map<String, dynamic> data,String deviceToken) async {
    final serverkey = 'AAAA2qI7Pq4:APA91bGxse8Whupb5vs0wYInlw-dXHLRODQs4MyXZb0DVYssacZpJH-lRHr-Fc6S2kvgIuWW3Ii30YH47ErKn4UrHORaUWxYUh2z-tXVsO23JCD0tNmUJdHz280JsyJPIR1toPC0d-U6';
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverkey',
        },
        body:jsonEncode(
            <String, dynamic>{
              'notification':<String, dynamic>{
                'body':message,// 'this is a body',
                'title':title// 'this is a title'
              },
              'priority': 'high',
              'data':data,
              'to':'c-nNczck6X0:APA91bFQR4GFW-LPq6ul0k8VHkGUXo8EtLFmutVnux1v5qRwnbp_f_HW6XJQlY841hA0oFkvzdWv0-oXVgLFIjN2Nl_ePw0r28s60kdeATjf5YZAItXL4ybgbtFjLFPRmkE2FeS8WGw3',
            })
    );
  }
}