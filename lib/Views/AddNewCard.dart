import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/AddMasterCard.dart';

class AddNewCard extends StatefulWidget {
  @override
  _AddNewCardState createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
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
                    width:sizeScreen.width-155,
                    child:Text(
                      'Add New Card',
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
            bottom:40,
            child:SafeArea(
              child:SingleChildScrollView(
                  physics:BouncingScrollPhysics(),
                child:SafeArea(
                  child:Container(
                  height:430,
                  decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(2),
                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.4),
                        spreadRadius:1,
                        blurRadius:10,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  margin:EdgeInsets.only(left:20),
                  width:sizeScreen.width-40,
                  child:Column(
                    children: <Widget>[
                      Container(
                        margin:EdgeInsets.only(top:30),
                        child:Text(
                          'ADD CARD',
                          style:TextStyle(
                              color:HexColor('41CEA4'),
                              fontFamily:kFontPoppins,
                              fontWeight:FontWeight.w600,
                              fontSize:16
                          ),
                        ),
                      ),
                      SizedBox(height:25,),
                      Container(
                        height:45,
                        margin:EdgeInsets.only(left:30,right:30),
                        padding:EdgeInsets.only(left:10,right:10),
                        decoration:BoxDecoration(
                            border:Border.all(
                                color:HexColor('C3CFE2')
                            ),
                            borderRadius:BorderRadius.circular(7)
                        ),
                        child:TextField(
                          keyboardAppearance:Brightness.light,
                          style:TextStyle(
                            fontFamily:kFontPoppins,
                            fontSize:12,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:'CARD NUMBER'
                          ),
                        ),
                      ),
                      SizedBox(height:14,),
                      Container(
                        height:45,
                        margin:EdgeInsets.only(left:30,right:30),
                        padding:EdgeInsets.only(left:10,right:10),
                        decoration:BoxDecoration(
                            border:Border.all(
                                color:HexColor('C3CFE2')
                            ),
                            borderRadius:BorderRadius.circular(7)
                        ),
                        child:TextField(
                          keyboardAppearance:Brightness.light,
                          style:TextStyle(
                            fontFamily:kFontPoppins,
                            fontSize:12,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:"CARDHOLDER'S NAME"
                          ),
                        ),
                      ),
                      SizedBox(height:14,),
                      Container(
                        height:45,
                        margin:EdgeInsets.only(left:30,right:30),
                        child:Row(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                height:45,
                                width:60,
                                alignment:Alignment.center,
                                decoration:BoxDecoration(
                                    border:Border.all(
                                        color:HexColor('C3CFE2')
                                    ),
                                    borderRadius:BorderRadius.circular(7)
                                ),
                                child:Row(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin:EdgeInsets.only(left:4,top:0),
                                      padding:EdgeInsets.only(top:0),
                                      width:33,
                                      child:TextField(
                                        keyboardAppearance:Brightness.light,
                                        textAlign:TextAlign.center,
                                        style:TextStyle(
                                          fontFamily:kFontPoppins,
                                          fontSize:13,
                                        ),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:'MM'
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child:Icon(
                                        Icons.keyboard_arrow_down,
                                        size:17,
                                        color:Colors.grey,
                                      ),
                                    )
                                  ],
                                )
                            ),
                            SizedBox(width:10,),
                            Container(

                                height:45,
                                width:sizeScreen.width-250,
                                alignment:Alignment.center,
                                decoration:BoxDecoration(
                                    border:Border.all(
                                        color:HexColor('C3CFE2')
                                    ),
                                    borderRadius:BorderRadius.circular(7)
                                ),
                                child:Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
//                                    color:Colors.red,
                                      margin:EdgeInsets.only(left:7,top:0,),
//                                    padding:EdgeInsets.only(top:5,right:5),
                                      width:sizeScreen.width-283,
                                      child:TextField(
                                        keyboardAppearance:Brightness.light,
                                        textAlign:TextAlign.left,
                                        style:TextStyle(
                                          fontFamily:kFontPoppins,
                                          fontSize:13,
                                        ),
                                        decoration:InputDecoration(
                                            border:InputBorder.none,
                                            hintText:'YYYY'
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child:Icon(
                                        Icons.keyboard_arrow_down,
                                        size:17,
                                        color:Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width:5,),
                                  ],
                                )
                            ),
                            SizedBox(width:10,),
                            Container(
                              height:45,
                              width:70,
                              padding:EdgeInsets.only(left:10,right:10),
                              decoration:BoxDecoration(
                                  border:Border.all(
                                      color:HexColor('C3CFE2')
                                  ),
                                  borderRadius:BorderRadius.circular(7)
                              ),
                              child:TextField(
                                keyboardAppearance:Brightness.light,
                                style:TextStyle(
                                  fontFamily:kFontPoppins,
                                  fontSize:12,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:'CVV'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:0,),
                      Container(
                        margin:EdgeInsets.only(left:20),
                        child:Row(
                          children: <Widget>[
                            IconButton(
                                icon:Image.asset(
                                  check,
                                  height:20,
                                ),
                                onPressed:() {
                                  print('object');
                                }),
                            Text(
                              'Save credit card information',
                              style:TextStyle(
                                  color:Colors.black,
                                  fontFamily:kFontPoppins,
//                              fontWeight:FontWeight.w600,
                                  fontSize:12
                              ),
                              maxLines:2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:12,),
                      Container(
                        height:45,
                        width:sizeScreen.width - 90,
                        decoration:BoxDecoration(
                          color:Colors.red,
                          gradient:LinearGradient(
                            begin:Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors:[
                              HexColor('38B3A3'),
                              HexColor('2D95A2'),
                              HexColor('2070A0'),
                            ],
                          ),
                          borderRadius:BorderRadius.circular(22),
                        ),
                        child:FlatButton(
                          textColor:Colors.white,
                          child:Text(
                            'Next Step',
                            textAlign:TextAlign.left,
                            style:TextStyle(
                                color:Colors.white,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w500,
                                fontSize:16
                            ),
                          ),
                          onPressed:() {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (context) => AddMasterCard()));
                          },
                        ),
                      ),
                      SizedBox(height:14,),
                      Container(
                        height:45,
                        width:sizeScreen.width - 90,
                        decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius:BorderRadius.circular(22),
                            border:Border.all(
                                color:HexColor('78B6FA'),
                                width:1
                            )
                        ),
                        child:FlatButton(
                          textColor:Colors.white,
                          child:Text(
                            'Back',
                            textAlign:TextAlign.left,
                            style:TextStyle(
                                color:HexColor('78B6FA'),
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w500,
                                fontSize:16
                            ),
                          ),
                          onPressed:() {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                )
              ),
            )
          )
        ],
      ),
    );
  }
}
