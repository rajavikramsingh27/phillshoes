import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/ViewService/ScanQRCodeService.dart';
import 'dart:async';
import 'dart:convert';
import 'package:phillshoes/ViewService/DashboardService.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';



class ServiceSeeker extends StatefulWidget {
  @override
  _ServiceSeekerState createState() => _ServiceSeekerState();
}



class _ServiceSeekerState extends State<ServiceSeeker> {
  double _dragStart = 0.0;
  double _hieght = 350;//30;
  double _currentPosition = 0.0;
  
  Map<String,dynamic> dictUserDetails = {};
  final fireStore = Firestore.instance;

  var arrTitle = ['House Cleaning','Bike Cleaning','Car Cleaning','Cook'];
  var arrPrice = ['200','120','250','500'];
  var arrTime = ['3','10','5','10'];
  var arrImage = ['assets/home.png','assets/bike.png',
                  'assets/car.png','assets/cook.png'];

  var sourceFirst = '';
  var sourceSecond = '';

  var destFirst = '';
  var destSecond = '';

  @override
  void initState() {
    super.initState();
    
    Future.delayed (Duration(seconds:1), () {
      dictUserDetails = json.decode(dictBookingDetails[kUserDetails]);
      _getPlaceSourceLocation(dictUserDetails[klatitude], dictUserDetails[klongitude]);

      final dictServiceProviderDetails = json.decode(dictBookingDetails[kServiceProviderDetails]);
      _getPlaceDestLocation(dictBookingDetails[klatitude], dictBookingDetails[klongitude]);
    });
  }

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
    sourceFirst = '${name}, ${subLocality}, ${locality}, ${administrativeArea}';
    sourceSecond = '${administrativeArea}';

    setState(() {

    });
  }

  _getPlaceDestLocation(String lat, String long) async {
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
    destFirst = '${name}, ${subLocality}, ${locality}, ${administrativeArea}';
    destSecond = '${administrativeArea}';

    setState(() {

    });
  }

  rejcetBooking_ServiceProviderDetails() {
    Map<String,dynamic> dataNotiReciever = json.decode(dictBookingDetails[kServiceProviderDetails]);

    fireStore.collection(kFireBaseNotifications).document(dataNotiReciever[kemail_ID]+kConnect+dataNotiReciever[kuserID]).
    collection(dictBookingDetails[kBookingID]).document(dictBookingDetails[kBookingID]).updateData({
      kStatusBooking:kStatusBookingRejected
    }).then((value) {
      Map<String,dynamic> dictUserDetails = json.decode(dictBookingDetails[kUserDetails]);
      sendNotification('Your booking is rejected by service provider', 'Please find another service provider', dictUserDetails[kdevice_token]);
      Navigator.pop(context);
    }).catchError((error) {
      print(error.toString());
    });
  }

  rejcetBooking_UserDetails() {
    Map<String,dynamic> dataNotiReciever = json.decode(dictBookingDetails[kUserDetails]);

    fireStore.collection(kFireBaseNotifications).document(dataNotiReciever[kemail_ID]+kConnect+dataNotiReciever[kuserID]).
    collection(dictBookingDetails[kBookingID]).document(dictBookingDetails[kBookingID]).updateData({
      kStatusBooking:kStatusBookingRejected
    }).then((value) {
      print('updated.....');
    }).catchError((error) {
      print(error.toString());
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

    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION
    );

    googleMap = GoogleMap(
      initialCameraPosition:initialLocation,
      myLocationEnabled:false,
      myLocationButtonEnabled:false,
        compassEnabled:false,
//        tiltGesturesEnabled: false,
//        markers: _markers,
//        polylines: _polylines,
      mapType: MapType.normal,
//        onMapCreated:onMapCreated
    );
    
    return Scaffold(
        appBar:setAppBar(),
        body:Container(
          width:sizeScreen.width,
          height:sizeScreen.height,
          child:Stack(
            children: <Widget>[
              Positioned(
                top:0,
                bottom:0,
                left:0,
                right:0,
                child:Container(
//                  width:sizeScreen.width,
//                  height:sizeScreen.height,
                  color:Colors.white,
                  child:googleMap,
                ),
              ),
              Positioned(
                  top:0,
                  child:Container(
                    padding:EdgeInsets.only(top:40,bottom:20),
                    decoration:BoxDecoration(
                      color:Colors.white,
                      boxShadow:[
                        setShadow()
                      ],
                    ),
                    child:Row(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin:EdgeInsets.only(left:30),
                          decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius:BorderRadius.circular(30),
                            boxShadow:[
                              BoxShadow (
                                color:Colors.grey.withOpacity(0.5),
                                spreadRadius:2,
                                blurRadius:10,
                                offset:Offset(0, 3),
                              )
                            ],
                          ),
                          child:CircleAvatar(
                            radius:25,
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
                          margin:EdgeInsets.only(left:16),
                          width:sizeScreen.width-30,
                          child:Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                                        width:sizeScreen.width,
                                  child: RichText(
                                    textAlign:TextAlign.left,
                                    text:
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:dictUserDetails[kname]+', ',
                                            style:TextStyle(
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w600,
                                                color:HexColor('2DBB54'),
                                                fontSize:14)
                                        ),
                                        TextSpan(
                                            text:" you'll be at your",
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
                              Container(
//                                      color:Colors.red,
                                width:sizeScreen.width-110,
                                child:Text(
                                  'place in 5 minutes',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w700,
                                      fontSize:24
                                  ),
                                  maxLines:2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              Positioned(
                  bottom:0,
                  child:SafeArea(
                      child:Visibility(
                        visible:true,
                        child:GestureDetector(
//                              key:_cardKey,
//                          onPanStart:(DragStartDetails details) {
//                            _dragStart = details.globalPosition.dy;
//                            _currentPosition = _hieght;
//                          },
//                          onPanUpdate:(DragUpdateDetails details) {
//
//                            setState(() {
//                              var _hieghtUpdating = _currentPosition - details.globalPosition.dy + _dragStart;
//                              if (_hieghtUpdating > 30 && _hieghtUpdating < 360) {
//                                _hieght = _hieghtUpdating;
//                              }
//                            });
//                          },
//                          onPanEnd:(DragEndDetails details) {
//                            _currentPosition = _hieght;
//                            setState(() {
//                              if (_hieght < 200) {
//                                _hieght = 30;
//                              } else {
//                                _hieght = 350;
//                              }
//                            });
//                          },
                          child:Container(
                              height:_hieght,
                              width:sizeScreen.width-40,
                              margin:EdgeInsets.only(left:20),
                              decoration:BoxDecoration(
                                color:Colors.white,
                                boxShadow:[
                                  BoxShadow(
                                    color:Colors.grey.withOpacity(0.4),
                                    spreadRadius:2,
                                    blurRadius:8,
                                    offset: Offset(0, 5),
                                  )
                                ],
                                 borderRadius:BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child:SingleChildScrollView(
                                physics:NeverScrollableScrollPhysics(),
                                child:Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height:12),
                                    Center(
                                      child:Container(
                                        alignment:Alignment.center,
                                        height:3,width:140,
                                        color:HexColor('C3CDD6'),
                                      ),
                                    ),
                                    SizedBox(height:4),
                                    Container(
                                      margin:EdgeInsets.only(left:20,top:10),
                                      child:Text(
                                        'Your Service Seeker:',
                                        style:TextStyle(
                                            color:Colors.black,
                                            fontFamily:kFontPoppins,
                                            fontWeight:FontWeight.w700,
                                            fontSize:18
                                        ),
                                        maxLines:2,
                                      ),
                                    ),
                                    SizedBox(height:10,),
                                    Container(
                                      margin:EdgeInsets.only(left:20,right:20),
                                      child:Container(
                                          height:62,
                                          child:Row(
                                            children:<Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    child:CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage: AssetImage(userPerson),
                                                    ),
                                                    height:60,
                                                    width:60,
                                                  ),
                                                  SizedBox(width:12,),
                                                ],
                                              ),
                                              SizedBox(width:10,),
                                              Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                mainAxisAlignment:MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width:sizeScreen.width-188,
                                                    alignment:Alignment.centerLeft,
                                                    child:Text(
                                                      dictUserDetails[kname],
                                                      style:TextStyle(
                                                          fontFamily:kFontPoppins,
                                                          fontSize:16,
                                                          fontWeight:FontWeight.w800
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:4),
                                                  Container(
                                                      child:Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.star_border,
                                                            color:HexColor('#2DBB54'),
                                                            size:22,
                                                          ),
                                                          Text(
                                                            '4.5 / 5',
                                                            style:TextStyle(
                                                                color:HexColor('#2DBB54'),
                                                                fontFamily:kFontPoppins,
                                                                fontSize:14,
                                                                fontWeight:FontWeight.w500
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                alignment:Alignment.bottomRight,
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
//                                                        dictServiceUserDetails[kname]
                                                        Container(
                                                          decoration:BoxDecoration(
                                                            boxShadow:[
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.25),
                                                                spreadRadius:2,
                                                                blurRadius:16,
                                                                offset: Offset(0, 5),
                                                              )
                                                            ],
                                                          ),
                                                          child:CircleAvatar(
                                                            radius:18,
                                                            backgroundColor:HexColor('78B6FA'),
                                                            child:IconButton(
                                                              icon:Icon(
                                                                Icons.call,
                                                                size:18,
                                                                color:Colors.white,
                                                              ),
                                                              onPressed:() {
                                                                print(dictUserDetails[kmobile]);
                                                                if (dictUserDetails[kmobile].toString().isEmpty) {
                                                                  Toast.show(
                                                                      'Phone number is not updated',
                                                                      context,
                                                                      backgroundColor:Colors.red,
                                                                      duration:2
                                                                  );
                                                                } else {
                                                                  launch("tel://"+dictUserDetails[kmobile]);
                                                                }
                                                              },
                                                            )
                                                          ),

                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                    SizedBox(height:20),
                                    Container(
//                                          color:Colors.red,
//                                          height:150,
                                      child:Column(
                                        children: <Widget>[
                                          Container(
                                            margin:EdgeInsets.only(left:30,right:30),
                                            height:2,
                                            decoration:BoxDecoration(
                                              color:HexColor('DFDFDF'),
                                            ),
                                          ),
                                          Container(
                                            child:Row(
                                              children: <Widget>[
                                                Container(
                                                    child:Column(
                                                      crossAxisAlignment:CrossAxisAlignment.start,
                                                      mainAxisAlignment:MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          crossAxisAlignment:CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                              width:40,
                                                              margin:EdgeInsets.only(left:20),
                                                              child:Column(
                                                                children: <Widget>[
                                                                  Container(
                                                                    height:10,
                                                                    width:10,
                                                                    margin:EdgeInsets.only(top:30),
                                                                    decoration:BoxDecoration(
                                                                        color:HexColor('#78B6FA'),
                                                                        borderRadius:BorderRadius.circular(5)
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height:6,
                                                                    width:6,
                                                                    margin:EdgeInsets.only(top:10),
                                                                    decoration:BoxDecoration(
                                                                        color:HexColor('#EFEFEF'),
                                                                        borderRadius:BorderRadius.circular(3)
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height:6,
                                                                    width:6,
                                                                    margin:EdgeInsets.only(top:5),
                                                                    decoration:BoxDecoration(
                                                                        color:HexColor('#EFEFEF'),
                                                                        borderRadius:BorderRadius.circular(3)
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height:6,
                                                                    width:6,
                                                                    margin:EdgeInsets.only(top:5),
                                                                    decoration:BoxDecoration(
                                                                        color:HexColor('#EFEFEF'),
                                                                        borderRadius:BorderRadius.circular(3)
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height:6,
                                                                    width:6,
                                                                    margin:EdgeInsets.only(top:5),
                                                                    decoration:BoxDecoration(
                                                                        color:HexColor('#EFEFEF'),
                                                                        borderRadius:BorderRadius.circular(3)
                                                                    ),
                                                                  ),
//                                                                      findddd
                                                                ],
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:CrossAxisAlignment.start,
                                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Container(
                                                                  width:sizeScreen.width-100,
                                                                  child:Column(
                                                                    crossAxisAlignment:CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      SizedBox(height:30,),
                                                                      Text(
                                                                        'From - ${destFirst}',
                                                                        style:TextStyle(
                                                                            color:HexColor('#999999'),
//                                                                                color:Colors.grey,
                                                                            fontFamily:kFontPoppins,
                                                                            fontWeight:FontWeight.w300,
                                                                            fontSize:12
                                                                        ),
                                                                      ),
                                                                      SizedBox(height:5,),
                                                                      Text(
                                                                        destSecond,
                                                                        style:TextStyle(
                                                                            color:Colors.black,
                                                                            fontFamily:kFontPoppins,
                                                                            fontWeight:FontWeight.w700,
                                                                            fontSize:16
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:CrossAxisAlignment.center,
                                                          mainAxisAlignment:MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                              height:6,
                                                              width:6,
                                                              margin:EdgeInsets.only(left:37,top:5),
                                                              decoration:BoxDecoration(
                                                                  color:HexColor('#EFEFEF'),
//                                                                      color:Colors.red,
                                                                  borderRadius:BorderRadius.circular(3)
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:Alignment.center,
//                                                                  color:Colors.red,
                                                              color:HexColor('EEEEEE'),
                                                              height:1,
                                                              margin:EdgeInsets.only(left:16,top:5),
                                                              width:sizeScreen.width-130,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                              width:40,
                                                              margin:EdgeInsets.only(left:20),
                                                              child:Column(
                                                                children: <Widget>[
                                                                  Container(
                                                                    height:6,
                                                                    width:6,
                                                                    margin:EdgeInsets.only(top:5),
                                                                    decoration:BoxDecoration(
                                                                        color:HexColor('#EFEFEF'),
                                                                        borderRadius:BorderRadius.circular(3)
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:CrossAxisAlignment.start,
                                                          mainAxisAlignment:MainAxisAlignment.start,
                                                          children:<Widget>[
                                                            Container(
                                                              width:40,
                                                              margin:EdgeInsets.only(left:20),
                                                              child:Column(
                                                                children: <Widget>[
                                                                  Container(
                                                                    height:10,
                                                                    width:10,
                                                                    margin:EdgeInsets.only(top:10),
                                                                    decoration:BoxDecoration(
                                                                        color:HexColor('#78B6FA'),
                                                                        borderRadius:BorderRadius.circular(5)
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
//                                                                  color:Colors.green,
                                                              child:Column(
                                                                children: <Widget>[
                                                                  Container(
                                                                    width:sizeScreen.width-105,
                                                                    child:Column(
                                                                      crossAxisAlignment:CrossAxisAlignment.start,
                                                                      children: <Widget>[
                                                                        SizedBox(height:5,),
                                                                        Text(
                                                                          'To - ${sourceFirst}',
                                                                          style:TextStyle(
//                                                                                  color:Colors.grey,
                                                                              color:HexColor('#999999'),
                                                                              fontFamily:kFontPoppins,
                                                                              fontWeight:FontWeight.w300,
                                                                              fontSize:12
                                                                          ),
                                                                        ),
                                                                        SizedBox(height:9,),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:sizeScreen.width-105,
                                                                    child:Row(
                                                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                                      children: <Widget>[
                                                                        Text(
                                                                          sourceSecond,
                                                                          style:TextStyle(
                                                                              color:Colors.black,
                                                                              fontFamily:kFontPoppins,
                                                                              fontWeight:FontWeight.w700,
                                                                              fontSize:16
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:30,
                                                                          width:60,
                                                                          margin:EdgeInsets.only(right:20),
                                                                          decoration:BoxDecoration(
//                                                                      color:Colors.red,
                                                                              border:Border.all(
                                                                                  color:Colors.grey,
                                                                                  width:1.5
                                                                              ),
                                                                              borderRadius:BorderRadius.circular(20)
                                                                          ),
                                                                          child:FlatButton(
                                                                            padding:EdgeInsets.all(0),
                                                                            child:Text(
                                                                              'Cancel',
                                                                              style:TextStyle(
                                                                                  color:Colors.black,
                                                                                  fontFamily:kFontPoppins,
                                                                                  fontSize:11
                                                                              ),
                                                                            ),
                                                                            onPressed: () {
                                                                                rejcetBooking_ServiceProviderDetails();
                                                                                rejcetBooking_UserDetails();
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) => ScanQRCodeService()));
                                                                              },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ),
                        ),
                      )
                  )
              ),
            ],
          ),
        )
    );
  }
}


