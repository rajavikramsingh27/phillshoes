import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/Notifications.dart';
import 'package:phillshoes/Views/MonthlyHistory.dart';
import 'package:phillshoes/Views/LoginType.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    var arrTextEmoji = ['Happy','Sad','Satisfied','Angry'];
    var arrIconEmoji = [happy,sad,satisfied,angry];

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
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.remove(kUserDetails);

                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginTypes()));
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
      body:Stack(
        children: <Widget>[
          Positioned(
            left:0,
            right:0,
            top:0,
            child:Container(
              height:340,
              child:Image.asset(curveBG,fit:BoxFit.fill),
            ),
          ),
          Positioned(
            top:0,
            bottom:0,
            left:0,
            right:0,
            child:SafeArea(
                bottom:false,
                child:SingleChildScrollView(
                    physics:BouncingScrollPhysics(),
                    child:Column(
                      children:<Widget>[
                        Container(
                          margin:EdgeInsets.only(left:16,right:16,bottom:8,top:8),
                          child:Column(
                            children:<Widget>[
                              Container(
                                width:sizeScreen.width,
                                padding:EdgeInsets.only(right:15),
                                alignment:Alignment.centerRight,
                                child:CircleAvatar(
                                    radius:18,
                                    backgroundColor:Colors.white,
                                    child:IconButton(
                                      icon:Icon(
                                        Icons.notifications_none,
                                        color:HexColor('C3CDD6'),
                                        size:20,
                                      ),
                                      onPressed:() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Notifications()));
                                      },
                                    )
                                ),
                              ),
                              Container(
                                  child:Row(
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child:CircleAvatar(
                                            radius:22,
                                            backgroundColor:Colors.white,
                                            child:IconButton(
                                              icon:Icon(
                                                Icons.arrow_back,
                                                color:HexColor('78B6FA'),
                                              ),
                                              onPressed:() {
                                                Navigator.pop(context);
                                              },
                                            )
                                        ),
                                        margin:EdgeInsets.only(left:20),
                                      ),
                                      Container(
                                        color:Colors.transparent,
                                        margin:EdgeInsets.only(left:16,right:30),
                                        width:sizeScreen.width-180,
                                        child:Text(
                                          'Profile',
                                          style:TextStyle(
                                              color:Colors.white,
                                              fontFamily:kFontPoppins,
                                              fontWeight:FontWeight.w700,
                                              fontSize:22
                                          ),
                                          maxLines:2,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Center(
                                child:FlatButton(
                                  child:Container(
                                    margin:EdgeInsets.only(top:30),
                                    child:CircleAvatar(
                                      radius:83,
                                      backgroundImage:AssetImage(userPerson),
                                    ),
                                    height:166,
                                    width:166,
                                    decoration:BoxDecoration(
                                      color:Colors.white,
                                      borderRadius:BorderRadius.circular(83),
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
                                  onPressed:() {
                                    print('object');
                                  },
                                )
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height:40,
                        ),
                        // day week month
                        Container(
                          width:sizeScreen.width-40,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget>[
                              Container(
                                width:(sizeScreen.width-60)/3,
                                height:44,
                                decoration:BoxDecoration(
                                    color:HexColor('#35AEA3'),
                                    borderRadius:BorderRadius.circular(30),
                                    border:Border.all(
                                        color:HexColor('#707070'),
                                        width:1
                                    )
                                ),
                                child:FlatButton(
                                  textColor:Colors.white,
                                  child:Text(
                                    'Day',
                                    style:TextStyle(
                                        color:Colors.black,
                                        fontFamily:kFontPoppins,
                                        fontSize:15,
                                        fontWeight:FontWeight.w700
                                    ),
                                  ),
                                  onPressed:() {
                                    print('Day');
                                  },
                                ),
                              ),
                              Container(
                                width:(sizeScreen.width-60)/3,
                                height:44,
                                decoration:BoxDecoration(
//                                    color:HexColor('#35AEA3'),
                                    borderRadius:BorderRadius.circular(30),
                                    border:Border.all(
                                        color:HexColor('#707070'),
                                        width:1
                                    )
                                ),
                                child:FlatButton(
                                  textColor:Colors.white,
                                  child:Text(
                                    'Week',
                                    style:TextStyle(
                                        color:Colors.black,
                                        fontFamily:kFontPoppins,
                                        fontSize:15,
                                        fontWeight:FontWeight.w700
                                    ),
                                  ),
                                  onPressed:() {
                                    isMonthly = false;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MonthlyHistory()));
                                  },
                                ),
                              ),
                              Container(
                                width:(sizeScreen.width-60)/3,
                                height:44,
                                decoration:BoxDecoration(
//                                    color:HexColor('#35AEA3'),
                                    borderRadius:BorderRadius.circular(30),
                                    border:Border.all(
                                        color:HexColor('#707070'),
                                        width:1
                                    )
                                ),
                                child:FlatButton(
                                  textColor:Colors.white,
                                  child:Text(
                                    'Month',
                                    style:TextStyle(
                                        color:Colors.black,
                                        fontFamily:kFontPoppins,
                                        fontSize:15,
                                        fontWeight:FontWeight.w700
                                    ),
                                  ),
                                  onPressed:() {
                                    isMonthly = true;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MonthlyHistory()));
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        // next back date and time
                        Container(
                          width:sizeScreen.width-40,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width:54,
                                height:54,
                                child:IconButton(
                                  icon:Image.asset(back),
                                  onPressed:() {
                                    print('back');
                                  },
                                ),
                              ),
                              Container(
                                  child:Column(
                                    children: <Widget>[
                                      Text(
                                        'Today',
                                        style:TextStyle(
                                            color:Colors.black,
                                            fontFamily:kFontPoppins,
                                            fontSize:15,
                                            fontWeight:FontWeight.w600
                                        ),
                                      ),
                                      SizedBox(height:4),
                                      Text(
                                        '21 March 2019',
                                        style:TextStyle(
                                            color:Colors.black,
                                            fontFamily:kFontPoppins,
                                            fontSize:16,
                                            fontWeight:FontWeight.w700
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Container(
                                width:54,
                                height:54,
                                child:IconButton(
                                  icon:Image.asset(next),
                                  onPressed:() {
                                    print('next');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // carDemo
                        Container(
                          height:110,
                          width:166,
                          color:Colors.red,
                          margin:EdgeInsets.only(top:16),
                          child:Image.asset(carDemo),
                        ),
                        // status clean time
                        Container(
//                          color:Colors.red,
                            margin:EdgeInsets.only(top:16,bottom:16),
                            height:44,
                            width:sizeScreen.width-32,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      like,
                                      height:24,
                                    ),
                                    SizedBox(
                                        width:10
                                    ),
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Status',
                                          style:TextStyle(
                                              fontFamily:kFontPoppins,
                                              fontSize:14,
                                              fontWeight:FontWeight.w500
                                          ),
                                        ),
                                        Text(
                                          'Done',
                                          style:TextStyle(
                                              fontFamily:kFontPoppins,
                                              fontSize:15,
                                              fontWeight:FontWeight.w700
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      clean,
                                      height:30,
                                    ),
                                    SizedBox(
                                        width:10
                                    ),
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Clean',
                                          style:TextStyle(
                                              fontFamily:kFontPoppins,
                                              fontSize:14,
                                              fontWeight:FontWeight.w500
                                          ),
                                        ),
                                        Text(
                                          'Outside',
                                          style:TextStyle(
                                              fontFamily:kFontPoppins,
                                              fontSize:15,
                                              fontWeight:FontWeight.w700
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      time,
                                      height:25,
                                    ),
                                    SizedBox(
                                        width:10
                                    ),
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Time',
                                          style:TextStyle(
                                              fontFamily:kFontPoppins,
                                              fontSize:14,
                                              fontWeight:FontWeight.w500
                                          ),
                                        ),
                                        Text(
                                          '10:00 AM',
                                          style:TextStyle(
                                              fontFamily:kFontPoppins,
                                              fontSize:15,
                                              fontWeight:FontWeight.w700
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                        ),
                        // cleaner mark zeneith
                        Container(
                          decoration:BoxDecoration(
//                            color:Colors.red,
                            border:Border(
                              top: BorderSide( //                   <--- left side
                                  color:HexColor('#B6B4B4'),
                                  width:1
                              ),
                              bottom: BorderSide( //                    <--- top side
                                  color:HexColor('#B6B4B4'),
                                  width:1
                              ),
                            ),
                          ),
                          width:sizeScreen.width,
                          height:90,
                          padding:EdgeInsets.only(left:16,right:16),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget>[
                              Container(
                                child:CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(userPerson),
                                ),
                                height:60,
                                width:60,
                              ),
                              Column(
//                                crossAxisAlignment:CrossAxisAlignment.start,
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width:sizeScreen.width-150,
                                    alignment:Alignment.centerLeft,
//                                    color:Colors.red,
                                    child:Text(
                                      'Cleaner',
                                      style:TextStyle(
                                          fontFamily:kFontPoppins,
                                          fontSize:16,
                                          fontWeight:FontWeight.w300
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:4),
                                  Container(
                                    width:sizeScreen.width-150,
                                    alignment:Alignment.centerLeft,
//                                    color:Colors.red,
                                    child:Text(
                                      'Mark Zeneith',
                                      style:TextStyle(
                                          fontFamily:kFontPoppins,
                                          fontSize:16,
                                          fontWeight:FontWeight.w800
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment:Alignment.bottomRight,
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child:CircleAvatar(
                                            radius:18,
                                            backgroundColor:HexColor('#1F6EA1'),
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
                                                offset:Offset(0, 5),
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
                          ),
                        ),
                        Container(
                          width:sizeScreen.width,
                          padding:EdgeInsets.only(left:20,right:20),
                          child:Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height:30,
                              ),
                              Text(
                                'How do you feel about this job?',
                                style:TextStyle(
                                    color:Colors.black,
                                    fontFamily:kFontPoppins,
                                    fontWeight:FontWeight.w700,
                                    fontSize:16
                                ),
                              ),
                              SizedBox(
                                height:20,
                              ),
                              Container(
                                width:sizeScreen.width,
                                height:100,
                                child:ListView.builder(
                                  scrollDirection:Axis.horizontal,
                                  itemCount:arrTextEmoji.length,
                                  itemBuilder:(context, index) {
                                    return Container(
                                      margin:EdgeInsets.only(left:5,right:5),
                                      child:Column(
                                        children: <Widget>[
                                          Container(
                                            height:35,
                                            width:50,
                                            child:Icon(Icons.insert_emoticon),
//                                            child:Image.asset(arrIconEmoji[index]),
                                            color:Colors.grey.withOpacity(0.3),
                                          ),
                                          SizedBox(height:6),
                                          Text(
                                            arrTextEmoji[index],
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w500,
                                                fontSize:14
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.end,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children: <Widget> [
                            Container(
                              color:Colors.transparent,
                              child:Text(
                                'Log out',
                                style:TextStyle(
                                    color:HexColor('41CEA4'),
                                    fontFamily:kFontPoppins,
                                    fontWeight:FontWeight.w700,
                                    fontSize:18
                                ),
                              ),
                            ),
                            Container(
                              margin:EdgeInsets.only(left:16,right:16),
                              child:CircleAvatar(
                                  radius:23,
                                  backgroundColor:HexColor('41CEA4'),
                                  child:IconButton(
                                    icon:Icon(
                                      Icons.arrow_forward,
                                      color:Colors.white,
                                      size:20,
                                    ),
                                    onPressed:() {
                                      print('log');
                                      showDialog();
                                    },
                                  )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:30,
                        ),
                      ],
                    )
                )
            ),
          )
        ],
      ),
    );
  }
}
