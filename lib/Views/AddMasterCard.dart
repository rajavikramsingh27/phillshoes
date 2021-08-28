import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:phillshoes/Views/AddNewCard.dart';

class AddMasterCard extends StatefulWidget {
  @override
  _AddMasterCardState createState() => _AddMasterCardState();
}

class _AddMasterCardState extends State<AddMasterCard> {
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
              height:230,
              child:Image.asset(curveBG,fit:BoxFit.fill),
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
//                    width:sizeScreen.width-155,
                    child:Text(
                      'Add Master Card',
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
              ),)
          ),
          Positioned(
            top:95,
            bottom:0,
            child:SingleChildScrollView(
              physics:BouncingScrollPhysics(),
              padding:EdgeInsets.only(top:20),
              child:Column(
                children: <Widget>[
                  Container(
                    height:200,
                    width:sizeScreen.width-60,
                    margin:EdgeInsets.only(left:30),
                    decoration:BoxDecoration(
                        color:HexColor('303030'),
                        borderRadius:BorderRadius.circular(12),
                        boxShadow:[
                          BoxShadow(
                            color:Colors.grey.withOpacity(0.3),
                            spreadRadius:1,
                            blurRadius:1,
                            offset: Offset(0, 0),
                          )
                        ]
                    ),
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin:EdgeInsets.only(top:20,left:20),
                          height:30,
                          width:25,
                          child:Image.asset(Logotype),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        Container(
                          width:sizeScreen.width-100,
                          height:30,
                          margin:EdgeInsets.only(left:20),
                          child:Text(
                            '2145  0875  5325  2355',
                            style:TextStyle(
                                color:Colors.white,
                                fontFamily:kFontPoppins,
                                fontSize:20
                            ),
                            maxLines:2,
                          ),
                        ),
                        SizedBox(
                          height:16,
                        ),
                        Container(
                          width:sizeScreen.width-100,
                          margin:EdgeInsets.only(left:20),
                          child:Row(
                            children: <Widget>[
                              Container(
                                width:(sizeScreen.width-100)/2,
                                child:Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'MONTH/YEAR',
                                      style:TextStyle(
                                          color:Colors.white,
                                          fontFamily:kFontPoppins,
                                          fontSize:10
                                      ),
                                    ),
                                    Text(
                                      '12/22',
                                      style:TextStyle(
                                          color:Colors.white,
                                          fontFamily:kFontPoppins,
                                          fontSize:15
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width:(sizeScreen.width-100)/2,
                                child:Column(
                                  crossAxisAlignment:CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'CVC2/CVV2',
                                      style:TextStyle(
                                          color:Colors.white,
                                          fontFamily:kFontPoppins,
                                          fontSize:10
                                      ),
                                    ),
                                    Container(
                                      width:60,
                                      child:Text(
                                        'XXX',
                                        textAlign:TextAlign.left,
                                        style:TextStyle(
                                            color:Colors.white,
                                            fontFamily:kFontPoppins,
                                            fontSize:15
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height:16,
                        ),
                        Container(
                          width:sizeScreen.width-100,
                          margin:EdgeInsets.only(left:20),
                          child:Text(
                            'Mark Kowalsky',
                            style:TextStyle(
                                color:Colors.white,
                                fontFamily:kFontPoppins,
                                fontSize:15
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height:30,),
                  Container(
                    margin:EdgeInsets.only(left:30),
                    child:DottedBorder(
                      color:HexColor('D6D6D6'),
                      dashPattern: [5.5,5.5],
                      strokeWidth:1,
                      borderType:BorderType.RRect,
                      radius:Radius.circular(10),
                      padding: EdgeInsets.all(0),
                      child:ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child:Container(
                          height:200,
                          width:sizeScreen.width-60,
                          alignment:Alignment.center,
                          child:Text(
                            'Add new card',
                            style:TextStyle(
                                color:HexColor('D6D6D6'),
                                fontFamily:kFontPoppins,
                                fontSize:20,
                                fontWeight:FontWeight.w300
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:16,),
                  Container(
                    height:22,
                    child:Row(
                      children: <Widget>[
                        Icon(
                            Icons.camera_alt,
                            color:Colors.grey,
                        ),
                        Container(
                          height:22,
                          margin:EdgeInsets.only(left:5,top:4),
                          child:Text(
                            'Scan Credit Card',
                            style:TextStyle(
                                color:Colors.grey,
                                fontFamily:kFontPoppins,
                                fontSize:10,
                                fontWeight:FontWeight.w300
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height:35,),
                  Container(
                    margin:EdgeInsets.only(left:30),
                    alignment:Alignment.centerRight,
                    height:44,
                    width:sizeScreen.width-60,
                    child:Row(
                      mainAxisAlignment:MainAxisAlignment.end,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          color:Colors.transparent,
                          child:Text(
                            'Add new card',
                            style:TextStyle(
                                color:HexColor('206FA0'),
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w600,
                                fontSize:18
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(left:10,right:0),
                          child:CircleAvatar(
                              radius:22,
                              backgroundColor:HexColor('35AEA3'),
                              child:IconButton(
                                icon:Icon(
                                  Icons.arrow_forward,
                                  color:Colors.white,
                                  size:20,
                                ),
                                onPressed:() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AddNewCard()));
                                },
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:20,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

