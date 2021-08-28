import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'dart:async';

import 'package:google_maps_webservice/places.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:toast/toast.dart';
import 'package:dart_notification_center/dart_notification_center.dart';

Map<String, dynamic> dictDestination;

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  CameraPosition _position;

  final fireStore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var indexSelected = -1;

  List<Marker> arrMarkers = [];
  var strLocation = '';

  String address = '';

  void _updatePosition() async {
    kSelectedPosition = _position;

    Marker marker = arrMarkers.firstWhere(
            (p) => p.markerId == MarkerId('marker_2'),
        orElse: () => null);

    arrMarkers.remove(marker);
    arrMarkers.add(
      Marker(
        markerId:MarkerId('marker_2'),
        position:LatLng(_position.target.latitude, _position.target.longitude),
        draggable:true,
        icon:BitmapDescriptor.defaultMarker,
      ),
    );

    setState(() {

    });
  }

  _getPlace() async {
    List<Placemark> placemarkAddress = await Geolocator().placemarkFromCoordinates(
        _position.target.latitude,
        _position.target.longitude
    );

    Placemark placeMark  = placemarkAddress[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    address = '${name}, ${subLocality}, ${locality}, ${administrativeArea}, ${country}, ${postalCode}';
    kSelectedLocation = address;

    setState(() {

    });
  }

  update_location() async {
    showLoading(context);
    var tableName = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
    await _auth.currentUser().then((currentUser) {
      fireStore.collection(tableName).document(currentUser.email+kConnect+currentUser.uid).updateData({
        klatitude:_position.target.latitude.toString(),
        klongitude:_position.target.longitude.toString(),
        klocal_address:address
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
  }

  @override
  Widget build(BuildContext context) {
    Mode _mode = Mode.overlay;
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
        myLocationEnabled: true,
        myLocationButtonEnabled:true,

        markers:Set.from(arrMarkers),

        mapType:MapType.normal,
        compassEnabled:false,
        padding:EdgeInsets.only(top:1.0,),
//        onCameraMove: ((_position) => _updatePosition(_position)),
          onCameraIdle:() {
            print('mapDragged end');
            _getPlace();
          },
        onCameraMove: ((_positionMoving){
           _position = _positionMoving;
//          setState(() {
//          });
          _updatePosition();
        }),
      );
    }

    void onError(PlacesAutocompleteResponse response) {
      print(response.errorMessage);
    }

    Future<void> _handlePressButton() async {
      // show input autocomplete with selected mode
      // then get the Prediction selected
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: "fr",
        components: [Component(Component.country, "fr")],
      );

//      displayPrediction(p, homeScaffoldKey.currentState);
    }

    Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      scaffold.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }
  }

    return Scaffold(
      appBar:AppBar(
        brightness:Brightness.light,
        backgroundColor:Colors.white,
        elevation:0,
        title:Text(
          address,
          maxLines:3,
          style:TextStyle(
              color:Colors.black,
              fontFamily:kFontPoppins,
              fontSize:13
          ),
        ),
        leading:BackButton(
          color:Colors.black,
        ),
        centerTitle:true,
        actions:<Widget>[
          FlatButton(
            padding:EdgeInsets.only(right:0),
            child:Text(
            'Done',
            style:TextStyle(
                color:Colors.green,
                fontFamily:kFontPoppins,
                fontSize:18
            ),
          ),
            onPressed:() {
              if (kLocation == kUser) {
                visibiltySearchForDest = false;
                visibiltyMyHome = true;

                dictDestination =  {
                 klatitude:_position.target.latitude.toString(),
                 klongitude:_position.target.longitude.toString(),
                 klocal_address:address
               };

                DartNotificationCenter.post(channel:kLocationUpdate, options:'updated Locations',);

                Navigator.pop(context, () {

                });
              } else {
                update_location();
              }
            },
          ),
          SizedBox(width:20,)
        ],
      ),
      body:SingleChildScrollView(
        physics:NeverScrollableScrollPhysics(),
        child:Column(
          children: <Widget>[
            Container(
                padding:EdgeInsets.only(bottom:5),
                decoration:BoxDecoration(
                  color:Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color:Colors.grey,
                        blurRadius:1,
                        spreadRadius:1,
                        offset:Offset(0,0)
                    )
                  ],
                ),
                child:FlatButton(
                  padding:EdgeInsets.all(0),
                  child:Container(
                    height:50,
                    width:MediaQuery.of(context).size.width,
                    decoration:BoxDecoration(
                        color:Colors.white,
                        borderRadius:BorderRadius.circular(25),
                        border:Border.all(
                            color:Colors.grey,
                            width:1
                        )
                    ),
                    margin:EdgeInsets.only(
                        left:20,right:20,
                        top:10,bottom:0
                    ),
                    alignment:Alignment.center,
                    child:Text(
                      'Search your location ... ',
                      style:TextStyle(
                          color:Colors.grey,
                          fontFamily:kFontPoppins,
                          fontWeight:FontWeight.normal,
                          fontSize:16
                      ),
                    ),
                  ),
                  onPressed:() {
                    print('search...');
                    _handlePressButton();
                  },
                )
            ),
            Container(
              color:Colors.white,
              width:MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height
                        -50-MediaQuery.of(context).padding.bottom-100,
              margin:EdgeInsets.only(top:3,bottom:0),
              child:googleMap,
            )
          ],
        ),
      )
    );
  }
}


