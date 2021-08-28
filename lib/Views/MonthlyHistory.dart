import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';

var isMonthly = false;

class MonthlyHistory extends StatefulWidget {
  @override
  _MonthlyHistoryState createState() => _MonthlyHistoryState();
}

class _MonthlyHistoryState extends State<MonthlyHistory> {
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
                          height:222,
                          child:ListView.builder(
                            padding:EdgeInsets.only(bottom:40),
                            scrollDirection:Axis.vertical,
                            itemCount:isMonthly ? 30 : 7,
                            itemBuilder:(context, index) {
                              if ( index == 0 ) {
                                return Container(
                                  height:100,
                                  margin:EdgeInsets.only(left:30,right:30,bottom:8,top:30),
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
                                              ),
                                              Container(
                                                margin:EdgeInsets.only(left:20,right:20),
                                                width:sizeScreen.width-180,
                                                child:Text(
                                                  isMonthly ? 'Monthly' : 'This week',
                                                  style:TextStyle(
                                                      color:Colors.white,
                                                      fontFamily:kFontPoppins,
                                                      fontWeight:FontWeight.w600,
                                                      fontSize:20
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
                                return Container(
//                                    height:140,
                                    margin:EdgeInsets.only(left:0,right:0,top:6,bottom:6),
                                    child:Column(
                                    children: <Widget>[
                                      Container(
                                        width:sizeScreen.width-40,
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                width:sizeScreen.width-60,
                                                alignment:Alignment.center,
                                                child:Column(
                                                  children: <Widget>[
                                                    Text(
                                                      (index).toString()+' June 2020',
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
//                                          color:Colors.red,
                                          margin:EdgeInsets.only(top:30,bottom:16,left:25,right:25),
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
                                      Container(
                                        width:sizeScreen.width,
                                        height:1,
                                        color:HexColor('B6B4B4'),
                                      ),
                                    ],
                                  ),
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


