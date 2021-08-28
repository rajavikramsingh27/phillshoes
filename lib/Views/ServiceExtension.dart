import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/Views/ScanQRCode.dart';


class ServiceExtension extends StatefulWidget {
  @override
  _ServiceExtensionState createState() => _ServiceExtensionState();
}

class _ServiceExtensionState extends State<ServiceExtension> {

  double _dragStart = 0.0;
  double _hieght = 420;//100;
  double _currentPosition = 0.0;
//  GlobalKey _cardKey = GlobalKey();
  var visibiltySelectAnOption = true;

  var arrTitle = ['House Cleaning','Bike Cleaning','Car Cleaning','Cook'];
  var arrPrice = ['200','120','250','500'];
  var arrTime = ['3','10','5','10'];
  var arrImage = ['assets/home.png','assets/bike.png',
    'assets/car.png','assets/cook.png'];

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
//        compassEnabled: true,
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
                    children: <Widget>[
                      Container(
                        height:60,
                        width:60,
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
                          radius: 50,
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
                        margin:EdgeInsets.only(left:30,right:30),
                        width:sizeScreen.width,
                        child:Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: sizeScreen.width - 50,
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text:
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Veer,',
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
                            Text(
                              'place in 5 minutes',
                              style:TextStyle(
                                  color:Colors.black,
                                  fontFamily:kFontPoppins,
                                  fontWeight:FontWeight.w600,
                                  fontSize:20
                              ),
                              maxLines:2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom:0,
                  child:SafeArea(
                      child:Visibility(
                        visible:visibiltySelectAnOption,
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
//                              if (_hieghtUpdating > 120 && _hieghtUpdating < 420) {
//                                _hieght = _hieghtUpdating;
//                              }
//                            });
//                          },
//
//                          onPanEnd:(DragEndDetails details) {
//                            _currentPosition = _hieght;
//
//                            setState(() {
//                              if (_hieght < 200) {
//                                _hieght = 100;
//                              } else {
//                                _hieght = 420;
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
                                    Container(
                                      margin:EdgeInsets.only(left:20,top:10),
                                      child:Text(
                                        'Service Extension:',
                                        style:TextStyle(
                                            color:Colors.black,
                                            fontFamily:kFontPoppins,
                                            fontWeight:FontWeight.w700,
                                            fontSize:16
                                        ),
                                        maxLines:2,
                                      ),
                                    ),
                                    SizedBox(height:10),
                                    Container(
                                      height:40,
                                      child:ListView.builder(
                                        padding:EdgeInsets.only(left:10,right:20),
                                        scrollDirection:Axis.horizontal,
                                        itemCount:4,
                                        itemBuilder:(context, index) {
                                          return Container(
                                            width:80,
                                            margin:EdgeInsets.only(left:10),
                                            decoration:BoxDecoration(
                                              color:HexColor('78B6FA'),
                                              borderRadius:BorderRadius.circular(20),
                                            ),
                                            child:Row(
//                                            mainAxisAlignment:MainAxisAlignment.start,
//                                            crossAxisAlignment:CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width:40,
//                                                color:Colors.red,
                                                  child:IconButton(
                                                      icon:CircleAvatar(
                                                        backgroundColor:HexColor('2DBB54'),
                                                        radius:14,
                                                        child:Icon(
                                                          Icons.add,
                                                          color:Colors.white,
                                                          size:20,
                                                        ),
                                                      )
                                                  ),
                                                ),
                                                Container(
                                                  margin:EdgeInsets.only(left:0),
//                                                color:Colors.green,
                                                  alignment:Alignment.center,
                                                  child:Text(
                                                    (index+1).toString()+' hr',
                                                    style:TextStyle(
                                                        color:Colors.black,
                                                        fontFamily:kFontPoppins,
                                                        fontWeight:FontWeight.w600,
                                                        fontSize:12
                                                    ),

                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
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
                                        'Your Service Attendess:',
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
                                                      'Wasilij Smith',
                                                      style:TextStyle(
                                                          fontFamily:kFontPoppins,
                                                          fontSize:16,
                                                          fontWeight:FontWeight.w800
                                                      ),
                                                    ),
                                                  ),
//                                              SizedBox(height:4),
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
                                                        Container(
                                                          child:CircleAvatar(
                                                            radius:18,
                                                            backgroundColor:HexColor('78B6FA'),
                                                            child:Icon(
                                                              Icons.call,
                                                              size:18,
                                                              color:Colors.white,
                                                            ),
                                                          ),
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
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                    SizedBox(height:10,),
                                    Container(
                                        margin:EdgeInsets.only(left:90,right:25),
                                        height:30,
                                        child:Stack(
                                          children: <Widget>[
                                            FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child:Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    'Scan the QR code',
                                                    style:TextStyle(
                                                      fontFamily:kFontPoppins,
                                                      fontSize:15,
//                                            fontWeight:FontWeight.w800
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:EdgeInsets.all(3.5),
                                                    height:50,
                                                    decoration:BoxDecoration(
                                                        color:Colors.white,
                                                        border:Border.all(
                                                            color:HexColor('#78B6FA'),
                                                            width:3
                                                        ),
                                                        borderRadius:BorderRadius.circular(7)
                                                    ),
                                                    child:Image.asset(
                                                      QR_code,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onPressed:() {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => ScanQRCode()));
                                              },
                                            ),
                                          ],
                                        )
                                    ),
                                    SizedBox(height:16,),
                                    Container(
                                      margin:EdgeInsets.only(left:20),
                                      child:Text(
                                        'Service Add-Ons:',
                                        style:TextStyle(
                                            color:Colors.black,
                                            fontFamily:kFontPoppins,
                                            fontWeight:FontWeight.w700,
                                            fontSize:16
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:10),
                                    Container(
//                                  color:Colors.green,
                                      height:120,
                                      child:ListView.builder(
                                        padding:EdgeInsets.only(left:10,right:20),
                                        scrollDirection:Axis.vertical,
                                        itemCount:3,
                                        itemBuilder:(context, index) {
                                          return Container(
                                            height:40,
                                            margin:EdgeInsets.only(left:10),
                                            child:Row(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Car Cleaning',
                                                  style:TextStyle(
                                                      color:Colors.black,
                                                      fontFamily:kFontPoppins,
//                                                  fontWeight:FontWeight.w600,
                                                      fontSize:14
                                                  ),
                                                  maxLines:2,
                                                ),
                                                Container(
                                                    height:30,
                                                    width:70,
                                                    decoration:BoxDecoration(
                                                        border:Border.all(
                                                            color:HexColor('707070'),
                                                            width:1
                                                        ),
                                                        borderRadius:BorderRadius.circular(15)
                                                    ),
                                                    child:FlatButton(
                                                      textColor:Colors.white,
                                                      padding:EdgeInsets.all(0),
                                                      onPressed:() {
                                                        print('object');
                                                      },
                                                      child:Row(
                                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          SizedBox(width:3),
                                                          Text(
                                                            'Add',
                                                            style:TextStyle(
                                                                color:Colors.black,
                                                                fontFamily:kFontPoppins,
                                                                fontWeight:FontWeight.w500,
                                                                fontSize:12
                                                            ),
                                                          ),
                                                          Container(
                                                            width:23,
                                                            height:23,
                                                            alignment:Alignment.center,
                                                            decoration:BoxDecoration(
                                                                color:HexColor('#2DBB54'),
                                                                borderRadius:BorderRadius.circular(15)
                                                            ),
                                                            child:Icon(
                                                              Icons.add,
                                                              color:Colors.white,
                                                              size:18,
                                                            ),
                                                          ),
                                                          SizedBox(width:0),
                                                        ],
                                                      ),)
                                                )
                                              ],
                                            ),
                                          );
                                        },
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

