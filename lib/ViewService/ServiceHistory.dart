import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/Notifications.dart';
import 'package:phillshoes/Views/ServiceExtension.dart';

class ServiceHistory extends StatefulWidget {
  @override
  _ServiceHistoryState createState() => _ServiceHistoryState();
}

class _ServiceHistoryState extends State<ServiceHistory> {
  @override
  Widget build(BuildContext context) {

    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
        body:Stack(
            children: <Widget>[
              Positioned(
                left:0,
                right:0,
                top:0,
                child:Container(
                  height:330,
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
                    child:Container(
                        child:Container(
//                          height:180,
                          child:ListView.builder(
                            scrollDirection:Axis.vertical,
                            itemCount:6,
                            itemBuilder:(context, index) {
                              if ( index == 0 ) {
                                return Container(
                                  height:130,
                                  margin:EdgeInsets.only(right:10,bottom:8,top:50),
//                                  color:Colors.red,
                                  child:Column(
                                    children: <Widget>[
                                      Container(
                                          child:Row(
                                            children: <Widget>[
                                              Container(
                                                child:CircleAvatar(
                                                    radius:25,
                                                    backgroundColor:Colors.white,
                                                    child:IconButton(
                                                      icon:Icon(
                                                        Icons.arrow_back,
                                                        color:HexColor('2DBB54'),
                                                      ),
                                                      onPressed:() {
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                ),
                                                margin:EdgeInsets.only(left:20),
                                              ),
                                              Container(
                                                margin:EdgeInsets.only(left:20,right:20),
                                                width:sizeScreen.width-180,
                                                child:Text(
                                                  'Service History',
                                                  style:TextStyle(
                                                      color:Colors.white,
                                                      fontFamily:kFontPoppins,
                                                      fontWeight:FontWeight.w700,
                                                      fontSize:24
                                                  ),
                                                  maxLines:2,
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  child:Container(
                                      height:180,
                                      margin:EdgeInsets.only(left:20,right:20,bottom:16),
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
                                          borderRadius:BorderRadius.circular(12)
                                      ),
                                      child:Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment:MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width:40,
                                                margin:EdgeInsets.only(left:0),
                                                child:Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height:8,
                                                      width:8,
                                                      margin:EdgeInsets.only(top:20),
                                                      decoration:BoxDecoration(
                                                          color:HexColor('#2DBB54'),
                                                          borderRadius:BorderRadius.circular(4)
                                                      ),
                                                    ),
                                                    Container(
                                                      height:5,
                                                      width:5,
                                                      margin:EdgeInsets.only(top:6),
                                                      decoration:BoxDecoration(
                                                          color:HexColor('#EFEFEF'),
                                                          borderRadius:BorderRadius.circular(3)
                                                      ),
                                                    ),
                                                    Container(
                                                      height:5,
                                                      width:5,
                                                      margin:EdgeInsets.only(top:3),
                                                      decoration:BoxDecoration(
                                                          color:HexColor('#EFEFEF'),
                                                          borderRadius:BorderRadius.circular(3)
                                                      ),
                                                    ),
                                                    Container(
                                                      height:5,
                                                      width:5,
                                                      margin:EdgeInsets.only(top:3),
                                                      decoration:BoxDecoration(
                                                          color:HexColor('#EFEFEF'),
                                                          borderRadius:BorderRadius.circular(3)
                                                      ),
                                                    ),
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
                                                        SizedBox(height:16),
                                                        Text(
                                                          'From - Kamieńskiego 11, Cracow',
                                                          style:TextStyle(
                                                              color:HexColor('#999999'),
//                                                                                color:Colors.grey,
                                                              fontFamily:kFontPoppins,
                                                              fontWeight:FontWeight.w200,
                                                              fontSize:14
                                                          ),
                                                        ),
                                                        SizedBox(height:0),
                                                        Text(
                                                          'Bonarka City Center',
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
                                                height:5,
                                                width:5,
                                                margin:EdgeInsets.only(left:18,top:3),
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
                                                margin:EdgeInsets.only(left:10,top:3),
                                                width:sizeScreen.width-130,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width:40,
                                                margin:EdgeInsets.only(left:0.5),
                                                child:Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height:5,
                                                      width:5,
                                                      margin:EdgeInsets.only(top:3),
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
                                                margin:EdgeInsets.only(left:1),
                                                child:Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height:8,
                                                      width:8,
                                                      margin:EdgeInsets.only(top:5),
                                                      decoration:BoxDecoration(
                                                          color:HexColor('#2DBB54'),
                                                          borderRadius:BorderRadius.circular(5)
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
//                                                               color:Colors.green,
                                                child:Column(
                                                  children: <Widget>[
                                                    Container(
                                                      width:sizeScreen.width-105,
                                                      child:Column(
                                                        crossAxisAlignment:CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          SizedBox(height:0),
                                                          Text(
                                                            'To - Kobierzyńska Street, Cracow ',
                                                            style:TextStyle(
//                                                                                  color:Colors.grey,
                                                                color:HexColor('#999999'),
                                                                fontFamily:kFontPoppins,
                                                                fontWeight:FontWeight.w200,
                                                                fontSize:14
                                                            ),
                                                          ),
                                                          SizedBox(height:0,),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width:sizeScreen.width-105,
                                                      child:Row(
                                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            'My Home',
                                                            style:TextStyle(
                                                                color:Colors.black,
                                                                fontFamily:kFontPoppins,
                                                                fontWeight:FontWeight.w700,
                                                                fontSize:16
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
                                          Container(
                                            color:HexColor('DDDDDD'),
                                            height:0.5,
                                            width:sizeScreen.width-120,
                                            margin:EdgeInsets.only(top:16,left:40),
                                          ),
                                          Container(
                                            width:sizeScreen.width-122,
                                            margin:EdgeInsets.only(top:14,left:40),
                                            child:Row(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child:RichText(
                                                    text:TextSpan(
                                                      text: 'ID:',
                                                      style:TextStyle(
                                                          color:HexColor('#CCCCCC'),
                                                          fontFamily:kFontPoppins,
                                                          fontWeight:FontWeight.w700,
                                                          fontSize:10
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:'5431443675434214',
                                                          style:TextStyle(
                                                              color:HexColor('#CCCCCC'),
                                                              fontFamily:kFontPoppins,
                                                              fontWeight:FontWeight.w200,
                                                              fontSize:10
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin:EdgeInsets.only(right:0),
                                                  child:Text(
                                                    'Yesterday: 5:15 pm',
                                                    style:TextStyle(
                                                        color:HexColor('#CCCCCC'),
                                                        fontFamily:kFontPoppins,
                                                        fontWeight:FontWeight.w300,
                                                        fontSize:10
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  onTap:() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServiceExtension()));
                                  },
                                );
                              }
                            },
                          ),
                        )
                    )
                ),
              ),
            ]
        )
    );
  }
}

