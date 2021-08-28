
import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/ViewService/DashboardService.dart';

import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';



class SelectAnOption extends StatefulWidget {
  @override
  _SelectAnOptionState createState() => _SelectAnOptionState();
}

class _SelectAnOptionState extends State<SelectAnOption> {
  List<Map<String, dynamic>> arrResult = [];

  var arrTitle = ['House Cleaning','Bike Cleaning','Car Cleaning','Cook'];
  var arrPrice = ['200','120','250','500'];
  var arrImage = ['assets/home.png','assets/bike.png',
    'assets/car.png','assets/cook.png'];

  var indexSelected = -1;

  final fireStore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> arrServiceList = [];

  @override
  void initState() {
    Future.delayed(Duration(seconds:1), () async {
      showLoading(context);
      QuerySnapshot querySnapshot = await fireStore.collection(kFireBaseServices).getDocuments();
      arrServiceList = querySnapshot.documents.map((DocumentSnapshot doc) {
        return doc.data;
      }).toList();
      dismissLoading(context);
      setState(() {

      });
    });

    super.initState();
  }

  updateData_FireBaseFireStore() {
    showLoading(context);
    _auth.currentUser().then((currentUser) {
      fireStore.collection(kFireBaseUser).document(currentUser.email+kConnect+currentUser.uid).updateData({
        kservice_id:arrServiceList[indexSelected][kid],
        kservice_name:arrServiceList[indexSelected][kname]
      }).catchError((error) {
        print(error.toString());
      }).then((value) {
        dismissLoading(context);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardService()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar:AppBar(
        brightness:Brightness.light,
        backgroundColor:Colors.white,
        elevation:1,
        title:Text(
          'Select an option',
          style:TextStyle(
              color:Colors.black,
              fontFamily:kFontPoppins
          ),
        ),
        leading:BackButton(
          color:Colors.black,
        ),
        centerTitle:true,
        actions: <Widget>[
          IconButton(
            icon:Icon(
              Icons.arrow_forward,
              color:Colors.green,
              size:30,
            ),
            onPressed:() {
              if (indexSelected > -1) {
                updateData_FireBaseFireStore();
              } else {
                Toast.show(
                    'Select a service',
                    context,
                    backgroundColor:Colors.red,
                    duration:2
                );
              }
            },
          ),
          SizedBox(width:20,)
        ],
      ),
      body:ListView.builder(
        physics:BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top:30,
          bottom:30,
        ),
        scrollDirection:Axis.vertical,
        itemCount:arrServiceList.length,
        itemBuilder:(context, index) {
          return GestureDetector(
            onTap:() {
              indexSelected = index;
              setState(() {

              });
            },
            child:Container(
                height:100,
                margin:EdgeInsets.only(right:40,left:40,bottom:20),
                padding:EdgeInsets.only(right:20,left:20),
                decoration:BoxDecoration(
                  color: (indexSelected == index)
                      ? HexColor('#78B6FA')
                      : HexColor('D6D6D6'),
                  borderRadius:BorderRadius.circular(12),
                  boxShadow:[
                    BoxShadow(
                      color: (indexSelected == index)
                          ? HexColor('#78B6FA').withOpacity(0.6)
                          : HexColor('D6D6D6').withOpacity(0.6),
                      spreadRadius:5,
                      blurRadius:13,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      arrServiceList[index][kname],
                      style:TextStyle(
                          color: (indexSelected == index)
                              ? Colors.white
                              : Colors.black,
                          fontWeight:FontWeight.w700,
                          fontSize:16
                      ),
                    ),
                    FadeInImage(
                      height:44,
                      width:44,
                      image:NetworkImage(arrServiceList[index][kIcon]),
                      placeholder:AssetImage('assets/home.png'),
                    )
                  ],
                )
            ),
          );
        },
      ),
    );
  }
}

