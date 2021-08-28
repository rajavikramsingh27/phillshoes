import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/AddMasterCard.dart';


class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  var arrPaymentType = ['CASH ON DELIVERY','VISA','VISA'];
  var arrSelectPaymentType = [false,false,false];



  @override
  Widget build(BuildContext context) {

    @override
    void initState() {
      super.initState();


    }


    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      body:Stack(
        children: <Widget>[
          Positioned(
            top:0,
            bottom:0,
            left:0,
            right:0,
              child:Image.asset(
                  bg,
                fit:BoxFit.fill,
              ),
          ),
          Positioned(
            top:16,
            left:0,
            right:0,
            child:SafeArea(child:Row(
              mainAxisAlignment:MainAxisAlignment.start,
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
                  color:Colors.transparent,
                  margin:EdgeInsets.only(left:20,right:20),
                  width:sizeScreen.width-155,
                  child:Text(
                    'Payment Method',
                    style:TextStyle(
                        color:Colors.white,
                        fontFamily:kFontPoppins,
                        fontWeight:FontWeight.w600,
                        fontSize:20
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
            ),)
          ),
          Positioned(
            bottom:0,
            top:116,
            left:0,
            right:0,
            child:Container(
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.only(
                    topRight:Radius.circular(20),
                    topLeft:Radius.circular(20)
                ),
              ),
              child:Column(
                children: <Widget>[
                  Container(
                    height:100,
                    width:sizeScreen.width-40,
                    margin:EdgeInsets.only(
                      left:20,right:20,top:20
                    ),
                    decoration:BoxDecoration(
                      color:Colors.white,
                      borderRadius:BorderRadius.circular(14),
                      boxShadow:[
                        BoxShadow(
                          color:Colors.grey.withOpacity(0.3),
                          spreadRadius:1.5,
                          blurRadius:1.5,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child:Column(
                      children: <Widget>[
                        SizedBox(height:10,),
                        Text(
                          'Total Payment',
                          style:TextStyle(
                              color:Colors.black,
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.w600,
                              fontSize:15
                          ),
                        ),
                        Text(
                          'Rs. 250',
                          style:TextStyle(
                              color:HexColor('2072A0'),
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.w400,
                              fontSize:15
                          ),
                        ),
                        Container(
                          height:40,
                          width:sizeScreen.width-80,
                          child:Row(
                            children:<Widget>[
                              Container(
                                width:(sizeScreen.width-80)/2,
                                child:Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Date',
                                      style:TextStyle(
                                          color:Colors.black,
                                          fontFamily:kFontPoppins,
                                          fontWeight:FontWeight.w300,
                                          fontSize:10
                                      ),
                                    ),
                                    Text(
                                      '12 Oct, 2019',
                                      style:TextStyle(
                                          color:Colors.black,
                                          fontFamily:kFontPoppins,
                                          fontWeight:FontWeight.w300,
                                          fontSize:10
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width:(sizeScreen.width-80)/2,
                                child:Column(
                                  crossAxisAlignment:CrossAxisAlignment.end,
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Time',
                                      style:TextStyle(
                                          color:Colors.black,
                                          fontFamily:kFontPoppins,
                                          fontWeight:FontWeight.w300,
                                          fontSize:10
                                      ),
                                    ),
                                    Text(
                                      '10:09 pm',
                                      style:TextStyle(
                                          color:Colors.black,
                                          fontFamily:kFontPoppins,
                                          fontWeight:FontWeight.w300,
                                          fontSize:10
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
                  ),
                  SizedBox(height:10,),
                  Container(
                    margin:EdgeInsets.only(left:20),
                    alignment:Alignment.centerLeft,
                    child:Text(
                      'Payment Method',
                      textAlign:TextAlign.left,
                      style:TextStyle(
                          color:Colors.black,
                          fontFamily:kFontPoppins,
                          fontWeight:FontWeight.w400,
                          fontSize:14
                      ),
                    ),
                  ),
                  SizedBox(height:10,),
                  Container(
                    height:167,
                    width:sizeScreen.width-40,
                    decoration:BoxDecoration(
                      color:Colors.white,
                      borderRadius:BorderRadius.circular(14),
                      boxShadow:[
                        BoxShadow(
                          color:Colors.grey.withOpacity(0.3),
                          spreadRadius:3,
                          blurRadius:6,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child:ListView.builder(
                      scrollDirection:Axis.vertical,
                      itemCount:3,
                      padding: EdgeInsets.all(0.0),
                      itemBuilder:(context, index) {
                        if (index == 0) {
                          return Container(
                            height:56,
                            child:Column(
                              children: <Widget>[
                                Container(
                                  height:55,
                                  child:Row(
                                    children: <Widget>[
                                      Container(
                                        margin:EdgeInsets.only(left:16,top:0),
                                        width:sizeScreen.width-110,
                                        child:Text(
                                          'CASH ON DELIVERY',
                                          textAlign:TextAlign.left,
                                          style:TextStyle(
                                              color:Colors.black,
                                              fontFamily:kFontPoppins,
                                              fontWeight:FontWeight.w400,
                                              fontSize:18
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          icon:Icon(
                                            arrSelectPaymentType[index]
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_unchecked,
                                            size:30,
                                          ),
                                          onPressed:() {
                                            setState(() {
                                              for (var i = 0; i < arrSelectPaymentType.length; i++) {
                                                if (i == index) {
                                                  arrSelectPaymentType[i] = true;
                                                } else {
                                                  arrSelectPaymentType[i] = false;
                                                }
                                              }
                                            });
                                          })
                                    ],
                                  ),
                                ),
                                Container(
                                  height:0.7,
                                  color:Colors.grey,
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            height:56,
                            child:Column(
                              children: <Widget>[
                                Container(
                                  height:55,
                                  child:Row(
                                    children: <Widget>[
                                      Container(
                                        margin:EdgeInsets.only(left:16,top:0),
                                        width:sizeScreen.width-110,
                                        child:Row(
                                          children: <Widget>[
                                            Container(
                                              width:50,
                                              height:16,
                                              child:Image.asset(visa),
                                            ),
                                            SizedBox(width:6,),
                                            Container(
                                              child:Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                mainAxisAlignment:MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Visa',
                                                    textAlign:TextAlign.left,
                                                    style:TextStyle(
                                                        color:HexColor('D4CBCB'),
                                                        fontFamily:kFontPoppins,
                                                        fontWeight:FontWeight.w400,
                                                        fontSize:10
                                                    ),
                                                  ),
                                                  Text(
                                                    '**** **** **** **23',
                                                    textAlign:TextAlign.left,
                                                    style:TextStyle(
                                                        color:HexColor('D4CBCB'),
                                                        fontFamily:kFontPoppins,
                                                        fontWeight:FontWeight.w400,
                                                        fontSize:10
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ),
                                      IconButton(
                                          icon:Icon(
                                            arrSelectPaymentType[index]
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_unchecked,
                                            size:30,
                                          ),
                                          onPressed:() {
                                            setState(() {
                                              for (var i = 0; i < arrSelectPaymentType.length; i++) {
                                                if (i == index) {
                                                  arrSelectPaymentType[i] = true;
                                                } else {
                                                  arrSelectPaymentType[i] = false;
                                                }
                                              }
                                            });
                                          })
                                    ],
                                  ),
                                ),
                                Container(
                                  height:0.7,
                                  color:Colors.grey,
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom:20,
            left:0,
            right:0,
            child:SafeArea(
              bottom:true,
              child:Center(
                child:Container(
                  width:200,
                  height:45,
                  decoration:BoxDecoration(
                    color:Colors.red,
                    gradient:LinearGradient(
                        colors:[
                          HexColor('38B3A3'),
                          HexColor('2D95A2'),
                          HexColor('2070A0'),
                        ],
                      ),
                    borderRadius:BorderRadius.circular(22),
                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.3),
                        spreadRadius:1,
                        blurRadius:10,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child:FlatButton(
                    textColor:Colors.white,
                    child:Text(
                      'Add New Card',
                      textAlign:TextAlign.left,
                      style:TextStyle(
                          color:Colors.white,
                          fontFamily:kFontPoppins,
                          fontWeight:FontWeight.w400,
                          fontSize:16
                      ),
                    ),
                    onPressed:() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddMasterCard()));
                    },
                  ),
                ),
              )
            )
          )
        ],
      ),
    );
  }
}


