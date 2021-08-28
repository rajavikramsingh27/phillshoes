import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'dart:async';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:phillshoes/ViewService/RatingUser.dart';


class PlaceService extends StatefulWidget {
  @override
  _PlaceServiceState createState() => _PlaceServiceState();
}

class _PlaceServiceState extends State<PlaceService> {
  double _dragStart = 0.0;
  double _hieght = 250;
  double _currentPosition = 0.0;
//  GlobalKey _cardKey = GlobalKey();
//  var visibiltySelectAnOption = true;

  var arrTitle = ['House Cleaning','Bike Cleaning','Car Cleaning','Cook'];
  var arrPrice = ['200','120','250','500'];
  var arrTime = ['3','10','5','10'];
  var arrImage = ['assets/home.png','assets/bike.png',
    'assets/car.png','assets/cook.png'];

  var visibileRequesting = true;
  var visibileOTP = false;
  var visibileRating = false;
  var visibileRequestingMonthly = false;

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
        appBar:PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar( // Here we create one to set status bar color
              backgroundColor: Colors.white,
              elevation:0,
              brightness:Brightness.light,// Set any color of status bar you want; or it defaults to your theme's primary color
            )
        ),
        body:Container(
          width:sizeScreen.width,
          height:sizeScreen.height,
          child:Stack(
            children: <Widget>[
              // for map
              Positioned(
                top:0,
                bottom:0,
                left:0,
                right:0,
                child:Container(
                  color:Colors.white,
                  child:googleMap,
                ),
              ),
              // navigation bar view
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
                              BoxShadow(
                                color:Colors.grey.withOpacity(0.5),
                                spreadRadius:2,
                                blurRadius:10,
                                offset: Offset(0, 3),
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
                                            text: 'Mark,',
                                            style:TextStyle(
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w600,
                                                color:HexColor('2DBB54'),
                                                fontSize:14)
                                        ),
                                        TextSpan(
                                            text:" you are at your",
                                            style: TextStyle(
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.normal,
                                                color: Colors.black,
                                                fontSize: 12
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
                                  'place',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w700,
                                      fontSize:24
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              // pan view
              Positioned(
                  bottom:0,
                  child:SafeArea(
                    child:GestureDetector(
//                      onPanStart:(DragStartDetails details) {
//                        _dragStart = details.globalPosition.dy;
//                        _currentPosition = _hieght;
//                      },
//
//                      onPanUpdate:(DragUpdateDetails details) {
//                        setState(() {
//                          var _hieghtUpdating = _currentPosition - details.globalPosition.dy + _dragStart;
//                          if (_hieghtUpdating > 30 && _hieghtUpdating < 260) {
//                            _hieght = _hieghtUpdating;
//                          }
//                        });
//                      },
//
//                      onPanEnd:(DragEndDetails details) {
//                        _currentPosition = _hieght;
//                        setState(() {
//                          if (_hieght < 200) {
//                            _hieght = 30;
//                          } else {
//                            _hieght = 250;
//                          }
//                        });
//                      },

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
                              topLeft:Radius.circular(12.0),
                              topRight:Radius.circular(12.0),
                            ),
                          ),
                          child:SingleChildScrollView(
                            physics:NeverScrollableScrollPhysics(),
                            child:Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child:Container(
                                    alignment:Alignment.center,
                                    height:3,
                                    width:140,
                                    margin:EdgeInsets.only(top:12),
                                    color:HexColor('C3CDD6'),
                                    child:Container(
                                      margin:EdgeInsets.only(left:36),
                                    ),
                                  ),
                                ),
//                                SizedBox(height:50),
                                Stack(
                                  children: <Widget>[
                                    Visibility(
                                      visible:visibileRequesting,
                                      child:Container(
                                        margin:EdgeInsets.only(left:36,top:50),
                                        color:Colors.white,
                                        child:Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Veer is requesting for the add-ons',
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:16
                                              ),
                                            ),
                                            SizedBox(height:20,),
                                            Text(
                                              'Are you willing to accept?',
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
                                              children: <Widget>[
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
                                                          fontFamily:kFontPoppins,
//                                                    fontWeight:FontWeight.w700,
                                                          fontSize:16
                                                      ),
                                                    ),
                                                    onPressed:() {
                                                      setState(() {
                                                        visibileRequesting = false;
                                                        visibileOTP = true;
                                                        visibileRating = false;
                                                        visibileRequestingMonthly = false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  height:45,
                                                  width:112,
                                                  margin:EdgeInsets.only(right:30),
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
                                                          fontFamily:kFontPoppins,
//                                                    fontWeight:FontWeight.w700,
                                                          fontSize:16
                                                      ),
                                                    ),
                                                    onPressed:() {
//                                                Navigator.push(
//                                                    context,
//                                                    MaterialPageRoute(builder: (context) => ChooseServiceProvider()));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    // OTP
                                    Visibility(
                                      visible:visibileOTP,
                                      child:Container(
                                        margin:EdgeInsets.only(left:36,top:50),
                                        color:Colors.white,
                                        child:Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'You service will end soon.',
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:18
                                              ),
                                            ),
                                            SizedBox(height:20),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  'Enter the OTP:',
                                                  style:TextStyle(
                                                      color:Colors.black,
                                                      fontFamily:kFontPoppins,
//                                                  fontWeight:FontWeight.w700,
                                                      fontSize:16
                                                  ),
                                                ),
                                                SizedBox(width:10),
                                                OTPTextField(
                                                  length:6,
                                                  width:sizeScreen.width-200,
                                                  fieldWidth:14,
                                                  style:TextStyle(
                                                      fontSize:15
                                                  ),
                                                  textFieldAlignment: MainAxisAlignment.spaceAround,
                                                  fieldStyle:FieldStyle.underline,
                                                  onChanged:(pin) {

                                                    setState(() {
                                                      if (pin.length == 6) {
                                                        visibileRequesting = false;
                                                        visibileOTP = false;
                                                        visibileRating = false;
                                                        visibileRequestingMonthly = true;
                                                      }
                                                    });
                                                  },
                                                  onCompleted:(pin) {
                                                    print("Completed: " + pin);
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Veer is requesting for the monthly service:
                                    Visibility(
                                      visible:visibileRequestingMonthly,
                                      child:Container(
                                        margin:EdgeInsets.only(left:36,top:50),
                                        color:Colors.white,
                                        child:Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Veer paid you for the service',
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:16
                                              ),
                                            ),
                                            SizedBox(height:20,),
                                            Text(
                                              'Are you willing to accept?',
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
                                              children: <Widget>[
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
                                                          fontFamily:kFontPoppins,
//                                                    fontWeight:FontWeight.w700,
                                                          fontSize:16
                                                      ),
                                                    ),
                                                    onPressed:() {
                                                      setState(() {
                                                        visibileRequesting = false;
                                                        visibileOTP = false;
                                                        visibileRating = true;
                                                        visibileRequestingMonthly = false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  height:45,
                                                  width:112,
                                                  margin:EdgeInsets.only(right:30),
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
                                                          fontFamily:kFontPoppins,
//                                                    fontWeight:FontWeight.w700,
                                                          fontSize:16
                                                      ),
                                                    ),
                                                    onPressed:() {
//                                                Navigator.push(
//                                                    context,
//                                                    MaterialPageRoute(builder: (context) => ChooseServiceProvider()));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Rating popup
                                    Visibility(
                                      visible:visibileRating,
                                      child:Container(
                                        margin:EdgeInsets.only(left:26,top:20),
                                        color:Colors.white,
                                        child:Stack(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Veer paid you for the service',
                                                  style:TextStyle(
                                                      color:Colors.black,
                                                      fontFamily:kFontPoppins,
                                                      fontWeight:FontWeight.w700,
                                                      fontSize:16
                                                  ),
                                                ),
                                                SizedBox(height:16),
                                                Text(
                                                  'Rate your experience',
                                                  style:TextStyle(
                                                      color:Colors.black,
                                                      fontFamily:kFontPoppins,
                                                      fontWeight:FontWeight.w700,
                                                      fontSize:16
                                                  ),
                                                ),
                                                SizedBox(height:10),
                                                Container(
                                                  child:Container(
                                                    width:220,
                                                    child:SmoothStarRating(
                                                      allowHalfRating:true,
                                                      starCount:5,
                                                      rating:0,
                                                      size:40,
                                                      isReadOnly:false,
                                                      defaultIconData:Icons.star_border,
                                                      filledIconData:Icons.star,
                                                      halfFilledIconData:Icons.star_half,
                                                      color:HexColor('36AEA3'),
                                                      borderColor:HexColor('36AEA3'),
                                                      spacing:5.0,
                                                      onRated:(v) {

                                                      },
                                                    )
                                                    ,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:10,
                                                ),
                                                Container(
//                                              color:Colors.red,
                                                  margin:EdgeInsets.only(left:0),
                                                  width:sizeScreen.width-80,
                                                  height:95,
                                                  child:Stack(
                                                    children: <Widget>[
                                                      Positioned(
                                                        child:Container(
                                                          height:50,
                                                          width:230,
                                                          padding:EdgeInsets.only(left:20,right:20,bottom:5),
                                                          decoration:BoxDecoration(
                                                            color:Colors.white,
                                                            borderRadius:BorderRadius.circular(12),
                                                            boxShadow:[
                                                              BoxShadow(
                                                                color:HexColor('303030').withOpacity(0.15),
                                                                spreadRadius:3,
                                                                blurRadius:6,
                                                                offset: Offset(0, 5), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child:TextFormField(
                                                            textInputAction: TextInputAction.done,
                                                            keyboardAppearance:Brightness.light,
                                                            maxLines:3,
                                                            style:TextStyle(
                                                              fontFamily:kFontPoppins,
                                                              fontSize:13,
                                                            ),
                                                            decoration: InputDecoration(
                                                              hintText: 'Any Feedback',
                                                              enabledBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(color:Colors.transparent),
                                                              ),
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(color:Colors.transparent),
                                                              ),
                                                              border: UnderlineInputBorder(
                                                                borderSide: BorderSide(color:Colors.transparent),
                                                              ),
                                                            ),
                                                            textAlign: TextAlign.left,
                                                            validator: (text) {
                                                              if (text == null || text.isEmpty) {
                                                                return 'Text is empty';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          bottom:0,
                                                          right:0,
                                                          child:Container(
//                                                        color:Colors.red,
                                                            width:sizeScreen.width-111,
                                                            child:Row(
                                                              mainAxisAlignment:MainAxisAlignment.end,
                                                              crossAxisAlignment:CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  color:Colors.transparent,
                                                                  child:Text(
                                                                    'Submit',
                                                                    style:TextStyle(
                                                                        color:HexColor('41CEA4'),
                                                                        fontFamily:kFontPoppins,
                                                                        fontWeight:FontWeight.w700,
                                                                        fontSize:15
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
//                                                        color:Colors.red,
                                                                  margin:EdgeInsets.only(left:10,right:0),
                                                                  child:CircleAvatar(
                                                                      radius:18,
                                                                      backgroundColor:HexColor('41CEA4'),
                                                                      child:IconButton(
                                                                        icon:Icon(
                                                                          Icons.arrow_forward,
                                                                          color:Colors.white,
                                                                          size:20,
                                                                        ),
                                                                        onPressed:() {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => RatingUser()));
                                                                        },
                                                                      )
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Positioned(
                                              right:0,
                                              top:0,
                                              child:Container(
                                                height:35,
                                                margin:EdgeInsets.only(top:0, right:0),
                                                child:IconButton(
                                                  iconSize:10,
                                                    icon:Image.asset(
                                                      cancelLight,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => RatingUser()));
                                                    }
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      ),
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}

