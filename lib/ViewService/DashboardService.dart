import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/ViewService/ServiceSeeker.dart';
import 'package:phillshoes/ViewService/ServiceHistory.dart';
import 'package:phillshoes/ViewService/ProfileService.dart';
import 'package:phillshoes/Views/LoginType.dart';
import 'package:phillshoes/ViewService/Location.dart';
import 'package:toast/toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

Map<String,dynamic> dictBookingDetails = Map<String,dynamic>();

class DashboardService extends StatefulWidget {
  @override
  _DashboardServiceState createState() => _DashboardServiceState();
}



class _DashboardServiceState extends State<DashboardService> {
  final ValueNotifier<bool> SwitchState = new ValueNotifier<bool>(true);
  Map<String, dynamic> dictUserDetails = Map<String, dynamic>();

  var arrHeader = ['Profile','Service History','Documents Upload','Invite Friends','Support','Log Out'];
  var localAddress = 'Select your address';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = Firestore.instance;
  var onlineStatus = '0';
  var isBooking = false;


  var addressFirst = '';
  var addressSecond = '';


  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
      getData_FireBaseFireStore();

      DartNotificationCenter.subscribe(
        channel:kBookingIsIncoming,
        observer:null,
        onNotification:(result) {
          isBooking = true;
//          print(result);
          dictBookingDetails = result;
          print(dictBookingDetails);
          print('11111111111111111111111111111111');

          _getPlaceSourceLocation(dictBookingDetails[klatitude], dictBookingDetails[klongitude]);
          setState(() {

          });
        },
      );
    });
    super.initState();
  }

  /*
  notificationDetails(String message, String title, String deviceToken,Map<String,dynamic> dictNoti_BookingDetails) async {
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
  }
*/

  _getPlaceSourceLocation(String lat, String long) async {
    List<Placemark> placemarkAddress = await Geolocator().placemarkFromCoordinates(
        double.parse(lat),
        double.parse(long)
    );

    Placemark placeMark  = placemarkAddress[0];

    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    addressFirst = '${name}, ${subLocality}, ${locality}, ${administrativeArea}';
    addressSecond = '${administrativeArea}';

    setState(() {

    });
  }

  acceptBooking_ServiceProviderDetails() {
    Map<String,dynamic> dataNotiReciever = json.decode(dictBookingDetails[kServiceProviderDetails]);

    fireStore.collection(kFireBaseNotifications).document(dataNotiReciever[kemail_ID]+kConnect+dataNotiReciever[kuserID]).
    collection(dictBookingDetails[kBookingID]).document(dictBookingDetails[kBookingID]).updateData({
        kStatusBooking:kStatusBookingAccepted
      }).then((value) {
        print('updated.....');
//        isBooking = false;
        setState(() {

        });
//        Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => ServiceSeeker()));
    }).catchError((error) {
      print(error.toString());
    });
  }

  acceptBooking_UserDetails() {
    Map<String,dynamic> dataNotiReciever = json.decode(dictBookingDetails[kUserDetails]);

    fireStore.collection(kFireBaseNotifications).document(dataNotiReciever[kemail_ID]+kConnect+dataNotiReciever[kuserID]).
    collection(dictBookingDetails[kBookingID]).document(dictBookingDetails[kBookingID]).updateData({
      kStatusBooking:kStatusBookingAccepted
    }).then((value) {
      print('updated.....');
    }).catchError((error) {
      print(error.toString());
    });
  }

  rejcetBooking_ServiceProviderDetails() {
    Map<String,dynamic> dataNotiReciever = json.decode(dictBookingDetails[kServiceProviderDetails]);

    fireStore.collection(kFireBaseNotifications).document(dataNotiReciever[kemail_ID]+kConnect+dataNotiReciever[kuserID]).
    collection(dictBookingDetails[kBookingID]).document(dictBookingDetails[kBookingID]).updateData({
      kStatusBooking:kStatusBookingRejected
    }).then((value) {
      print('updated.....');
//      isBooking = false;
//      setState(() {
//
//      });


    }).catchError((error) {
      print(error.toString());
    });
  }

  rejcetBooking_UserDetails() {
    Map<String,dynamic> dataNotiReciever = json.decode(dictBookingDetails[kUserDetails]);

    fireStore.collection(kFireBaseNotifications).document(dataNotiReciever[kemail_ID]+kConnect+dataNotiReciever[kuserID]).
    collection(dictBookingDetails[kBookingID]).document(dictBookingDetails[kBookingID]).updateData({
      kStatusBooking:kStatusBookingRejected
    }).then((value) async {
      print('updated.....');

      Map<String,dynamic> dictUserDetails = json.decode(dictBookingDetails[kServiceProviderDetails]);
      print(dictUserDetails[kdevice_token]);
//      sendNotification('Your booking is rejected by service provider', 'Please find another service provider', dictUserDetails[kdevice_token]);

      await http.post(
          'https://fcm.googleapis.com/fcm/send',
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$kFireBaseServerkey',
          },
          body:jsonEncode(
              <String, dynamic>{
                'notification':<String, dynamic>{
                  'body':'message',
                  'title':'title'
                },
                'priority':'high',
                'data':{'about':'this is the message'},
                'to':dictUserDetails[kdevice_token],
              })
      );

    }).catchError((error) {
      print(error.toString());
    });
  }

  getData_FireBaseFireStore() async {
    showLoading(context);
    await _auth.currentUser().then((currentUser) async {
      var tableName = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
      await fireStore.collection(tableName).document(currentUser.email+kConnect+currentUser.uid).get().then((value){
        dictUserDetails = value.data;
        localAddress = value.data[klocal_address];
        onlineStatus = value.data[kis_online];

        setState(() {

        });
      }).catchError((error) {
        print(error.toString());
        Toast.show(
            error.toString(),
            context,
            backgroundColor:Colors.red,
            duration:2
        );
      }).then((value) {
        dismissLoading(context);
      });
    });
  }

  online_offline() async {
    showLoading(context);
    await _auth.currentUser().then((currentUser) async {
      var tableName = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;

      await fireStore.collection(tableName).document(currentUser.email+kConnect+currentUser.uid).get().then((value){

        onlineStatus = (value.data[kis_online] == '1') ? '0' : '1';

       fireStore.collection(tableName).document((currentUser.email+kConnect+currentUser.uid)).updateData({
         kis_online:onlineStatus
       }).catchError((error) {
         print(error.toString());
         Toast.show(
             error.toString(),
             context,
             backgroundColor:Colors.red,
             duration:2
         );
       }).then((value) {
         print('updated..........');
         setState(() {

         });
       });
      }).catchError((error) {
        print(error.toString());
        Toast.show(
            error.toString(),
            context,
            backgroundColor:Colors.red,
            duration:2
        );
      }).then((value) {
        dismissLoading(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    GoogleMap googleMap;

    const double CAMERA_ZOOM = 13;
    const double CAMERA_TILT = 0;
    const double CAMERA_BEARING = 30;
    const LatLng SOURCE_LOCATION = LatLng(26.9124,75.7873);
    bool status = false;

    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION
    );

    if (googleMap == null) {
      googleMap = GoogleMap(
        initialCameraPosition:initialLocation,
        myLocationEnabled: false,
        myLocationButtonEnabled:false,
//        compassEnabled: true,
//        tiltGesturesEnabled: false,
//        markers: _markers,
//        polylines: _polylines,
        mapType: MapType.normal,
//        onMapCreated:onMapCreated
        compassEnabled:false,
//        mapType: MapType.normal,
//        trackCameraPosition: true,
        padding: EdgeInsets.only(top:1.0,),
      );
    }

    void showDialog() {
      showGeneralDialog(
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.7),
        transitionDuration: Duration(milliseconds:300),
        context: context,
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.bottomCenter,
            child:Material(
              color: Colors.transparent,
              child:Container(
                  height:220,
                  width:sizeScreen.width,
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  child:SafeArea(
                    top:false,
                    child:Column(
                      children: <Widget>[
                        SizedBox(
                          height:30,
                        ),
                        Text(
                          'Are you sure?',
                          style:TextStyle(
                              color:Colors.black,
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.bold,
                              fontSize:18
                          ),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        Text(
                          'Do you want to log out ?',
                          style:TextStyle(
                              color:Colors.black,
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.w500,
                              fontSize:16
                          ),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        FlatButton(
                          child:Text(
                            'Log Out',
                            style:TextStyle(
                                color:Colors.red,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w500,
                                fontSize:18
                            ),
                          ),
                          onPressed:() async {
                            await _auth.signOut().then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginTypes()));
                            });
                          },
                        ),
                        FlatButton(
                          child:Text(
                            'Cancel',
                            style:TextStyle(
                                color:Colors.grey,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w500,
                                fontSize:18
                            ),
                          ),
                          onPressed:() {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  )
              ),
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

    return Scaffold(
        appBar:setAppBar(),
        drawer:Drawer(
            child:SafeArea(
              child:ListView(
                padding:EdgeInsets.only(top: 20),
                children: <Widget>[
                  Container(
                    height:120,
                    color:Colors.white,
                    child:Column(
                      children: <Widget>[
                        Container(
                          color:Colors.white,
                          child:Row(
                            children: <Widget>[
                              SizedBox(width:20,),
                              Container(
                                decoration:BoxDecoration(
                                  color:Colors.white,
                                  borderRadius:BorderRadius.circular(30),
                                ),
                                child:FadeInImage(
                                  fit:BoxFit.fill,
                                  height:44,
                                  width:44,
                                  image:NetworkImage(
                                      (dictUserDetails[kprofile] == null)
                                          ? ''
                                          : dictUserDetails[kprofile]
                                  ),
                                  placeholder:AssetImage(userPerson),
                                )
                              ),
                              Container(
                                margin:EdgeInsets.only(left:20),
                                child:Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Good morning,',
                                      style:TextStyle(
                                          color:Colors.black,
                                          fontFamily:kFontPoppins,
                                          fontWeight:FontWeight.w700,
                                          fontSize:24
                                      ),
                                    ),
                                    SizedBox(height:5,),
                                    Text(
                                      dictUserDetails[kname],
                                      style:TextStyle(
                                          color:Colors.black,
                                          fontFamily:kFontPoppins,
                                          fontWeight:FontWeight.w700,
                                          fontSize:24
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height:44),
                        Container(
                          height:1,
                          width:sizeScreen.width,
                          color:Colors.grey.withOpacity(0.4),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
//              scrollDirection:Axis.vertical,
                    itemCount:arrHeader.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    itemBuilder:(context, index) {
                      return GestureDetector(
                        onTap:() {
                          Navigator.pop(context);// close the drawer
print(index);
                          print(arrHeader.last);
                          if (index == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProfileService()));
                          } else if (index == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ServiceHistory()));
                          } else if (index == arrHeader.length-1) {
                            showDialog();
                          }
                        },
                        child:Container(
                          color:Colors.white,
                          height:50,
                          margin:EdgeInsets.only(left:20),
                          child:Text(
                            arrHeader[index],
                            style:TextStyle(
                                color:Colors.black,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w700,
                                fontSize:24
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height:100,
                    child:Container(
                      color:Colors.white,
                    ),
                  ),
                  Container(
                      margin:EdgeInsets.only(left:20),
                      color:Colors.white,
                      child:Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Do more',
                            style:TextStyle(
                                color:HexColor('#726E6E'),
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w700,
                                fontSize:13
                            ),
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Text(
                            'Make money driving',
                            style:TextStyle(
                                color:HexColor('#726E6E'),
                                fontFamily:kFontPoppins,
                                fontSize:12
                            ),
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Text(
                            'Rate us on store',
                            style:TextStyle(
                                color:HexColor('#726E6E'),
                                fontFamily:kFontPoppins,
//                        fontWeight:FontWeight.w700,
                                fontSize:12
                            ),
                          ),
                          SizedBox(
                            height:50,
                          ),
                        ],
                      )
                  ),
                ],
              ),
            )
        ),
        body:SingleChildScrollView(
          physics:NeverScrollableScrollPhysics(),
          child:Container(
            width:sizeScreen.width,
            height:sizeScreen.height,
            child:Stack(
              children: <Widget>[
                Positioned(
//                  top:0,
//                  bottom:0,
                  left:0,
                  right:0,
                  child:Container(
                    width:sizeScreen.width,
                    height:sizeScreen.height-30,
                    color:Colors.white,
                    child:googleMap,
                  ),
                ),
                Positioned(
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width:sizeScreen.width,
                        decoration:BoxDecoration(
                          color:Colors.white,
                          boxShadow:[
                            setShadow()
                          ],
                        ),
                        padding:EdgeInsets.only(bottom:10),
                        child:Column(
                          children: <Widget>[
                            Container(
                              margin:EdgeInsets.only(left:20,top:10,right:20),
                              child:SafeArea(
                                  child:Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius:22,
                                        backgroundColor:HexColor('41CEA4'),
                                        child:Builder(
                                          builder:(context) => IconButton(
                                            icon:CircleAvatar(
                                              radius:22,
                                              backgroundColor:HexColor('41CEA4'),
                                              child:Icon(
                                                Icons.menu,
                                                color:Colors.white,
                                              ),
                                            ),
                                            onPressed: () => Scaffold.of(context).openDrawer(),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:sizeScreen.width-225,
                                        margin:EdgeInsets.only(left:0,right:0),
                                        alignment:Alignment.centerLeft,
                                        child:FlatButton(
                                          textColor:Colors.white,
                                          onPressed:() {
                                            print('object');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => Location()));
                                          },
                                          child:Text(
                                            localAddress,
                                            textAlign:TextAlign.left,
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w500,
                                                fontSize:10
                                            ),
                                            maxLines:3,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:44,
                                        width:140,
                                        decoration:BoxDecoration(
                                        color:Colors.white,
                                          borderRadius:BorderRadius.circular(22),
                                          boxShadow:[
                                            BoxShadow(
                                              color:Colors.grey.withOpacity(0.5),
                                              spreadRadius:2,
                                              blurRadius:6,
                                              offset: Offset(0, 3),
                                            )
                                          ],
                                        ),
                                        padding:EdgeInsets.all(0),
                                        child:Stack(
                                          children: <Widget>[
                                            Visibility(
                                              visible:(onlineStatus == '1')
                                              ? true : false,
                                              child:Container(
                                                height:44,
                                                width:140,
                                                decoration:BoxDecoration(
                                                  color:HexColor('#41CEA4'),
                                                  borderRadius:BorderRadius.circular(22),
                                                ),
                                                child:Stack(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                      children:<Widget>[
                                                        SizedBox(width:18,),
                                                        Text(
                                                          'Online',
                                                          style:TextStyle(
                                                              color:Colors.black,
                                                              fontFamily:kFontPoppins,
                                                              fontWeight:FontWeight.w500,
                                                              fontSize:16
                                                          ),
                                                          maxLines:2,
                                                        ),
                                                        Image.asset(onlineSwitch)
                                                      ],
                                                    ),
                                                    Positioned(
                                                      top:0,
                                                      bottom:0,
                                                      left:0,
                                                      right:0,
                                                      child:FlatButton(
                                                        textColor:Colors.white,
                                                        onPressed: () {
                                                          online_offline();
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible:(onlineStatus == '0')
                                                  ? true : false,
                                              child:Container(
                                                  height:44,
                                                  width:140,
                                                  decoration:BoxDecoration(
                                                    color:Colors.white,
                                                    borderRadius:BorderRadius.circular(22),
                                                  ),
                                                  child:Stack(
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Image.asset(offlineSwitch),
                                                          Text(
                                                            'Offline',
                                                            style:TextStyle(
                                                                color:Colors.black,
                                                                fontFamily:kFontPoppins,
                                                                fontWeight:FontWeight.w500,
                                                                fontSize:16
                                                            ),
                                                            maxLines:2,
                                                          ),
                                                          SizedBox(width:18,),
                                                        ],
                                                      ),
                                                      Positioned(
                                                        top:0,
                                                        bottom:0,
                                                        left:0,
                                                        right:0,
                                                        child:FlatButton(
                                                          onPressed:() {
                                                            online_offline();
                                                          },
                                                        )
                                                      )
                                                    ],
                                                  )
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(height:10),
                            Container(
                              color:Colors.white.withOpacity(0.8),
                              child:Row(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children:<Widget>[
                                  SizedBox(width:20,),
                                  Container(
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
                                    child:ClipRRect(
                                        borderRadius:BorderRadius.circular(30),
                                        child:FadeInImage(
                                          fit:BoxFit.fill,
                                          height:44,
                                          width:44,
                                          image:NetworkImage(
                                              (dictUserDetails[kprofile] == null)
                                                  ? ''
                                                  : dictUserDetails[kprofile]
                                          ),
                                          placeholder:AssetImage(userPerson),
                                        )
                                    ),
                                  ),
                                  Container(
                                    margin:EdgeInsets.only(left:20),
                                    width:sizeScreen.width-95,
                                    child:Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Good morning, '+dictUserDetails[kname],
                                          style:TextStyle(
                                              color:Colors.black,
//                          fontFamily:kFontPoppins,
                                              fontWeight:FontWeight.w600,
                                              fontSize:12
                                          ),
                                          maxLines:2,
                                        ),
                                        SizedBox(height:10,),
                                        Text(
                                          'Service Request Nearby Today',
                                          style:TextStyle(
                                              color:Colors.black,
                                              fontFamily:kFontPoppins,
                                              fontWeight:FontWeight.w700,
                                              fontSize:22
                                          ),
                                          maxLines:2,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height:16),
                      Visibility(
                        visible:isBooking,
                        child:Container(
                          height:160,
                          width:sizeScreen.width-50,
                          margin:EdgeInsets.only(left:25),
                          decoration:BoxDecoration(
                              color:Colors.white,
                              boxShadow:[
                                BoxShadow(
                                  color:Colors.grey.withOpacity(0.2),
                                  spreadRadius:2,
                                  blurRadius:3,
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius:BorderRadius.circular(35)
                          ),
                          child:Container(
                            margin:EdgeInsets.only(left:22),
                            child:Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height:26),
                                Text(
                                  addressFirst,
                                  style:TextStyle(
                                      color:HexColor('D6D6D6'),
                                      fontFamily:kFontPoppins,
//                                    fontWeight:FontWeight.w700,
                                      fontSize:12
                                  ),
                                ),
                                SizedBox(height:5,),
                                Text(
                                  addressSecond,
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w700,
                                      fontSize:16
                                  ),
                                ),
                                SizedBox(height:30),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children:<Widget>[
                                    Container(
                                      height:45,
                                      width:112,
                                      decoration:BoxDecoration(
                                        gradient:LinearGradient(
                                          begin:Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors:[
                                            HexColor('38B3A3'),
                                            HexColor('2D95A2'),
                                            HexColor('2070A0'),
                                          ],
                                        ),
                                        borderRadius:BorderRadius.circular(22),
                                        boxShadow:[
                                          BoxShadow(
                                            color:HexColor('5D9FFF').withOpacity(0.5),
                                            spreadRadius:2,
                                            blurRadius:10,
                                            offset: Offset(0,10),
                                          )
                                        ],
                                      ),
                                      child:FlatButton(
                                        textColor:Colors.white,
                                        child:Text(
                                          'ACCEPT',
                                          textAlign:TextAlign.left,
                                          style:TextStyle(
                                              color:Colors.white,
//                                        fontFamily:kFontPoppins,
                                              fontWeight:FontWeight.w700,
                                              fontSize:16
                                          ),
                                        ),
                                        onPressed:() {
                                          acceptBooking_ServiceProviderDetails();
                                          acceptBooking_UserDetails();
                                        },
                                      ),
                                    ),
                                    Container(
                                      height:45,
                                      width:112,
                                      margin:EdgeInsets.only(right:22),
                                      decoration:BoxDecoration(
                                        gradient:LinearGradient(
                                          begin:Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors:[
                                            HexColor('38B3A3'),
                                            HexColor('2D95A2'),
                                            HexColor('2070A0'),
                                          ],
                                        ),
                                        borderRadius:BorderRadius.circular(22),
                                        boxShadow:[
                                          BoxShadow(
                                            color:HexColor('5D9FFF').withOpacity(0.5),
                                            spreadRadius:2,
                                            blurRadius:10,
                                            offset: Offset(0,10),
                                          )
                                        ],
                                      ),
                                      child:FlatButton(
                                        textColor:Colors.white,
                                        child:Text(
                                          'REJECT',
                                          textAlign:TextAlign.left,
                                          style:TextStyle(
                                              color:Colors.white,
//                                        fontFamily:kFontPoppins,
                                              fontWeight:FontWeight.w700,
                                              fontSize:16
                                          ),
                                        ),
                                        onPressed:() {
                                          rejcetBooking_ServiceProviderDetails();
                                          rejcetBooking_UserDetails();
//                                        Navigator.push(
//                                            context,
//                                            MaterialPageRoute(builder: (context) => ChooseServiceProvider()));
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}


