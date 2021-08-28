import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/Notifications.dart';


class ServiceHistoryUser extends StatefulWidget {
  @override
  _ServiceHistoryUserState createState() => _ServiceHistoryUserState();
}

class _ServiceHistoryUserState extends State<ServiceHistoryUser> {
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
//              bottom:false,
              child:Column(
                children:<Widget>[
                  Container(
                      margin:EdgeInsets.only(top:50),
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
                                    color:HexColor('#2DBB54'),
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
                              'Service History',
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
                  SizedBox(
                    height:40,
                  ),
                  Container(
                    margin:EdgeInsets.only(left:20,right:20),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height:90,
                          width:(sizeScreen.width-70)/3,
                          decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius:BorderRadius.circular(10),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius:6,
                                blurRadius:6,
                                offset:Offset(0, 3),
                              )
                            ],
                          ),
                          child:Column(
//                            mainAxisAlignment:MainAxisAlignment.center,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height:8
                              ),
                              Image.asset(
                                coins,
                                height:34,
                              ),
                              SizedBox(
                                  height:8
                              ),
                              Text(
                                'Income Today:',
                                style:TextStyle(
                                    fontFamily:kFontPoppins,
                                    fontSize:10,
                                    fontWeight:FontWeight.w700
                                ),
                              ),
                              SizedBox(
                                  height:5
                              ),
                              Text(
                                'Rs. 4500',
                                style:TextStyle(
                                    fontFamily:kFontPoppins,
                                    fontSize:10,
                                    fontWeight:FontWeight.w300
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height:90,
                          width:(sizeScreen.width-70)/3,
                          decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius:BorderRadius.circular(10),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius:6,
                                blurRadius:6,
                                offset:Offset(0, 3),
                              )
                            ],
                          ),
                          child:Column(
//                            mainAxisAlignment:MainAxisAlignment.center,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height:8
                              ),
                              Image.asset(
                                bank,
                                height:34,
                              ),
                              SizedBox(
                                  height:8
                              ),
                              Text(
                                'Payment Today:',
                                style:TextStyle(
                                    fontFamily:kFontPoppins,
                                    fontSize:10,
                                    fontWeight:FontWeight.w700
                                ),
                              ),
                              SizedBox(
                                  height:5
                              ),
                              Text(
                                'Rs. 450',
                                style:TextStyle(
                                    fontFamily:kFontPoppins,
                                    fontSize:10,
                                    fontWeight:FontWeight.w300
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height:90,
                          width:(sizeScreen.width-70)/3,
                          decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius:BorderRadius.circular(10),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius:6,
                                blurRadius:6,
                                offset:Offset(0, 3),
                              )
                            ],
                          ),
                          child:Column(
//                            mainAxisAlignment:MainAxisAlignment.center,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height:8
                              ),
                              Image.asset(
                                exchange,
                                height:34,
                              ),
                              SizedBox(
                                  height:8
                              ),
                              Text(
                                'Amount Today:',
                                style:TextStyle(
                                    fontFamily:kFontPoppins,
                                    fontSize:10,
                                    fontWeight:FontWeight.w700
                                ),
                              ),
                              SizedBox(
                                  height:5
                              ),
                              Text(
                                'Rs. 4570',
                                style:TextStyle(
                                    fontFamily:kFontPoppins,
                                    fontSize:10,
                                    fontWeight:FontWeight.w300
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:20,
                  ),
                  Container(
                    width:sizeScreen.width,
                    height:sizeScreen.height-280-MediaQuery.of(context).padding.top,
                    margin:EdgeInsets.only(left:20,right:20),
                    decoration:BoxDecoration(
                      color:Colors.white,
                      borderRadius:BorderRadius.circular(10),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius:2,
                          blurRadius:6,
                          offset:Offset(0,0),
                        )
                      ],
                    ),
                    child:ListView.builder(
                      padding:EdgeInsets.only(top:10),
                      scrollDirection:Axis.vertical,
                      itemCount:6,
                      itemBuilder:(context, index) {
                        if (index ==  0) {
                          return Container(
                            margin:EdgeInsets.only(left:16,top:10),
                            width:sizeScreen.width,
                            height:40,
//                            color:Colors.red,
                            child:Text(
                              'Recent Transaction',
                              maxLines:2,
                              style:TextStyle(
                                color:Colors.black,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w700,
                                fontSize:16,
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            margin:EdgeInsets.only(left:0,right:0),
                            height:126,
                            child:Column(
                              mainAxisAlignment:MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:EdgeInsets.only(left:16,right:16),
                                  child:Text(
                                    'November 2019',
                                    style:TextStyle(
                                        color:Colors.black,
                                        fontFamily:kFontPoppins,
                                        fontWeight:FontWeight.w700,
                                        fontSize:14
                                    ),
                                    maxLines:2,
                                  ),
                                ),
                                Container(
                                  width:sizeScreen.width,
                                  height:1,
                                  color:HexColor('#AEABAB'),
                                  margin:EdgeInsets.only(top:10),
                                ),
                                Container(
                                    margin:EdgeInsets.only(left:16,right:16,top:16),
                                    child:Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '18th November 2019',
                                              maxLines:2,
                                              style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
//                                        fontWeight:FontWeight.w700,
                                                fontSize:11,
                                              ),
                                            ),
                                            Text(
                                              'Payment #23456',
                                              maxLines:2,
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:11
                                              ),
                                            ),
                                            Text(
                                              'Rs. 450',
                                              maxLines:2,
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
//                                        fontWeight:FontWeight.w700,
                                                  fontSize:11
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:10,
                                        ),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '18th November 2019',
                                              maxLines:2,
                                              style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
//                                        fontWeight:FontWeight.w700,
                                                fontSize:11,
                                              ),
                                            ),
                                            Text(
                                              'Payment #23456',
                                              maxLines:2,
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:11
                                              ),
                                            ),
                                            Text(
                                              'Rs. 450',
                                              maxLines:2,
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
//                                        fontWeight:FontWeight.w700,
                                                  fontSize:11
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:10,
                                        ),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '18th November 2019',
                                              maxLines:2,
                                              style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
//                                        fontWeight:FontWeight.w700,
                                                fontSize:11,
                                              ),
                                            ),
                                            Text(
                                              'Payment #23456',
                                              maxLines:2,
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:11
                                              ),
                                            ),
                                            Text(
                                              'Rs. 450',
                                              maxLines:2,
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
//                                        fontWeight:FontWeight.w700,
                                                  fontSize:11
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
