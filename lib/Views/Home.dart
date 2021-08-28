

import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:percent_indicator/percent_indicator.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  @override
  void initState() {
//    initializeDateFormatting();
//    Intl.systemLocale = 'en_En'; // to change the calendar format based on localization
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    var arrColor = ['FDCB6E','FF4880','FDCB6E'];
    var arrStatus = ['Pending','Accepted','Pending'];
    var arrDays = ['Yesterday','22 Aug, 2019','22 Aug 2019'];

    return Scaffold(
      body:Stack(
        children: <Widget>[
          Positioned(
            top:0,
            bottom:0,
            left:0,
            right:0,
            child:Image.asset(bg,fit:BoxFit.fill,),
          ),
          SafeArea(
            child:SingleChildScrollView(
              physics:BouncingScrollPhysics(),
              child:Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin:EdgeInsets.only(left:10),
                        child:IconButton(
                          icon:Icon(
                            Icons.arrow_back,
                            color:Colors.white,
                            size:26,
                          ),
                          onPressed:() {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        color:Colors.transparent,
                        margin:EdgeInsets.only(left:0,right:20),
                        width:sizeScreen.width-135,
                        child:Text(
                          'Home',
                          style:TextStyle(
                              color:Colors.white,
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.w300,
                              fontSize:18
                          ),
                          maxLines:2,
                        ),
                      ),
                      CircleAvatar(
                          radius:20,
                          backgroundColor:Colors.transparent,
                          child:IconButton(
                            icon:Icon(
                              Icons.notifications,
                              color:Colors.white,
                            ),
                            onPressed:() {
                              print('object');
                            },
                          )
                      ),
                    ],
                  ),
                  Container(
                    margin:EdgeInsets.only(left:20,right:30),
                    width:sizeScreen.width,
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Good Morning, Veer',
                          style:TextStyle(
                              color:Colors.white,
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.w300,
                              fontSize:14
                          ),
                          maxLines:2,
                        ),
                        Text(
                          'Leave Dashboard',
                          style:TextStyle(
                              color:Colors.white,
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.w600,
                              fontSize:24
                          ),
                          maxLines:2,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height:16,),
                  Container(
                      width:sizeScreen.width,
                      margin:EdgeInsets.only(left:10,right:10),
                      child:Column(
                        children: <Widget>[
                          Container(
                            margin:EdgeInsets.only(left:10,right:10),
                            child:Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '4 Leave',
                                  style:TextStyle(
                                      color:Colors.white,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w400,
                                      fontSize:12
                                  ),
                                  maxLines:2,
                                ),
                                Text(
                                  '24 Present',
                                  style:TextStyle(
                                      color:Colors.white,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w400,
                                      fontSize:12
                                  ),
                                  maxLines:2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height:6,),
                          LinearPercentIndicator(
                            lineHeight:4.0,
                            percent:0.3,
                            backgroundColor:Colors.white,
                            progressColor:HexColor('FFD34B'),
                          ),
                        ],
                      )
                  ),
                  SizedBox(height:16,),
                  Container(
                    height:280,
                    padding:EdgeInsets.only(left:16,right:16),
                    child:SomeCalendar(
                      primaryColor:HexColor('78B6FA'),//.withOpacity(0.8),
                      textColor:Colors.white,
                      mode: SomeMode.Range,
                      scrollDirection: Axis.horizontal,
                      isWithoutDialog: true,
//                            selectedDate: selectedDate,
                      startDate: Jiffy().subtract(years:100),
                      lastDate: Jiffy().add(months:100),
                      done:(date) {
                        setState(() {
//                                selectedDate = date;
//                                showSnackbar(selectedDate.toString());
                        });
                      },
                    ),
                  ),
                  Container(
                      alignment:Alignment.center,
                      height:46,
                      width:200,
                      padding:EdgeInsets.all(0),
                      decoration:BoxDecoration(
                          color:Colors.white,
                          borderRadius:BorderRadius.circular(23)
                      ),
                      child:SizedBox.expand(
                        child:FlatButton(
                          textColor:Colors.white,
                          onPressed:() {
                            print('Mark the leave');
                          },
                          child:Text(
                            'Mark the Leave',
                            textAlign:TextAlign.center,
                            style:TextStyle(
                                color:Colors.black,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w400,
                                fontSize:16
                            ),
                          ),
                        ),
                      )
                  ),
                  SizedBox(height:30,),
                  Container(
                    height:300,
                    child:ListView.builder(
                      padding:EdgeInsets.all(0.0),
                      scrollDirection:Axis.vertical,
                      itemCount:3,
                      itemBuilder:(context, index) {
                        return Container(
                            height:120,
                            child:Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:EdgeInsets.only(left:30,right:30),
                                  child:Text(
                                    arrDays[index],
                                    textAlign:TextAlign.left,
                                    style:TextStyle(
                                      fontFamily:kFontPoppins,
                                      fontSize:14,
                                    ),
                                  ),
                                ),
                                SizedBox(height:10,),
                                Container(
                                    height:74,
                                    margin:EdgeInsets.only(left:30,right:30),
                                    decoration:BoxDecoration(
                                      color:Colors.white,
                                      borderRadius:BorderRadius.circular(4),
                                    ),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:<Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child:CircleAvatar(
                                                backgroundColor:Colors.white,
                                                radius:16,
                                                backgroundImage:AssetImage(calendar2),
                                              ),
                                              alignment:Alignment.center,
                                              height:30,
                                              width:30,
                                              margin:EdgeInsets.only(left:10),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
//                                          color:Colors.red,
                                              width:sizeScreen.width-200,
                                              margin:EdgeInsets.only(left:0),
                                              alignment:Alignment.centerLeft,
                                              child:Text(
                                                'Applied Duration',
                                                style:TextStyle(
                                                  fontFamily:kFontPoppins,
                                                  fontSize:11,
//                                                fontWeight:FontWeight.w600
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:EdgeInsets.only(left:0),
                                              width:sizeScreen.width-200,
                                              child:Text(
                                                '12 Oct, 2019  to  15 Oct, 2019',
                                                style:TextStyle(
                                                  color:HexColor('4F5357'),
                                                  fontFamily:kFontPoppins,
                                                  fontSize:13,
//                                                fontWeight:FontWeight.w600
                                                ),
                                                maxLines:2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          crossAxisAlignment:CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              height:23,
                                              width:76,
                                              margin:EdgeInsets.only(right:0),
                                              padding:EdgeInsets.only(right:10),
                                              decoration: BoxDecoration(
                                                color:HexColor(arrColor[index]),
                                                borderRadius:BorderRadius.only(
                                                    topLeft:Radius.circular(40),
                                                    bottomLeft:Radius.circular(40)
                                                ),
                                              ),
                                              alignment:Alignment.center,
                                              child:Text(
                                                arrStatus[index],
                                                textAlign:TextAlign.center,
                                                style:TextStyle(
                                                    color:Colors.white,
                                                    fontFamily:kFontPoppins,
                                                    fontWeight:FontWeight.w400,
                                                    fontSize:10
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                ),
                              ],
                            )
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



