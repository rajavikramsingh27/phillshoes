import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:phillshoes/Views/PaymentMethod.dart';


class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
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
              child:SingleChildScrollView(
                  physics:BouncingScrollPhysics(),
                child:Column(
                  children: <Widget>[
                    Container(
                      margin:EdgeInsets.only(left:16,right:16,bottom:8,top:8),
                      child:Column(
                        children: <Widget>[
                          Container(
                            width:sizeScreen.width,
                            padding:EdgeInsets.only(right:15),
                            alignment:Alignment.centerRight,
                            child:CircleAvatar(
                                radius:20,
                                backgroundColor:Colors.white,
                                child:IconButton(
                                  icon:Icon(
                                    Icons.notifications_none,
                                    color:HexColor('C3CDD6'),
                                  ),
                                  onPressed:() {

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
                                        radius:25,
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
                                    margin:EdgeInsets.only(left:20,right:30),
                                    width:sizeScreen.width-180,
                                    child:Text(
                                      'You are in place!',
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
                          Center(
                            child:Container(
                              margin:EdgeInsets.only(top:30),
                              child:CircleAvatar(
                                radius:83,
                                backgroundImage: AssetImage(userPerson),
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
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height:40,
                    ),
                    Container(
                      child:Column(
                        children: <Widget>[
                          Text(
                            'Your Driver:',
                            style:TextStyle(
                                color:HexColor('D6D6D6'),
                                fontFamily:kFontPoppins,
//                                fontWeight:FontWeight.w600,
                                fontSize:14
                            ),
                            maxLines:2,
                          ),
                          Text(
                            'Wasilij Smith',
                            style:TextStyle(
                                color:Colors.black,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w600,
                                fontSize:20
                            ),
                            maxLines:2,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height:30,
                    ),
                    Container(
                      width:sizeScreen.width,
                      height:1,
                      color:Colors.grey.withOpacity(0.5),
                    ),
                    Container(
                      width:sizeScreen.width,
                      height:105,
                      child:Row(
                        children: <Widget>[
                          Container(
                            width:sizeScreen.width/3,
                            child:Column(
                              mainAxisAlignment:MainAxisAlignment.center,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Time:',
                                  textAlign:TextAlign.left,
                                  style:TextStyle(
                                      color:HexColor('D6D6D6'),
                                      fontFamily:kFontPoppins,
//                                fontWeight:FontWeight.w600,
                                      fontSize:14
                                  ),
                                ),
                                Text(
                                  '2 hrs',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w600,
                                      fontSize:20
                                  ),
                                  maxLines:2,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width:sizeScreen.width/3,
                            child:Column(
                              mainAxisAlignment:MainAxisAlignment.center,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Price:',
                                  style:TextStyle(
                                      color:HexColor('D6D6D6'),
                                      fontFamily:kFontPoppins,
//                                fontWeight:FontWeight.w600,
                                      fontSize:14
                                  ),
                                ),
                                Text(
                                  'Rs. 250',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w600,
                                      fontSize:20
                                  ),
                                  maxLines:2,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width:sizeScreen.width/3,
                            child:Column(
                              mainAxisAlignment:MainAxisAlignment.center,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Area:',
                                  style:TextStyle(
                                      color:HexColor('D6D6D6'),
                                      fontFamily:kFontPoppins,
//                                fontWeight:FontWeight.w600,
                                      fontSize:14
                                  ),
                                ),
                                Text(
                                  '1 BHK',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w600,
                                      fontSize:20
                                  ),
                                  maxLines:2,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width:sizeScreen.width,
                      height:1,
                      color:Colors.grey.withOpacity(0.5),
                    ),
                    SizedBox(
                      height:30,
                    ),
                    Container(
                      child:Column(
                        children: <Widget>[
                          Text(
                            'Mark,',
                            style:TextStyle(
                                color:HexColor('D6D6D6'),
                                fontFamily:kFontPoppins,
//                                fontWeight:FontWeight.w600,
                                fontSize:14
                            ),
                          ),
                          Text(
                            'How is the service?',
                            style:TextStyle(
                                color:Colors.black,
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w600,
                                fontSize:20
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height:30,
                    ),
                    Container(
                      child:Center(
                        child:Container(
//                          color:Colors.red,
                          alignment:Alignment.center,
//                          height:70,
                          width:sizeScreen.width-60,
                          child:SmoothStarRating(
                              allowHalfRating:true,
                              starCount:5,
                              rating:0,
                              size:(sizeScreen.width-80)/5,
                              isReadOnly:false,
                              defaultIconData:Icons.star_border,
                              filledIconData:Icons.star,
                              halfFilledIconData:Icons.star_half,
                              color:HexColor('36AEA3'),
                              borderColor:HexColor('36AEA3'),
                              spacing:5.0,
                              onRated:(v) {

                              },
                          )
                          ,
                        ),
                      ),
                    ),
                    SizedBox(
                      height:30,
                    ),
                    Container(
                        height:90,
                        width:sizeScreen.width-60,
                        padding:EdgeInsets.only(left:20,right:20,top:5,bottom:5),
                        decoration:BoxDecoration(
                          color:Colors.white,
                          borderRadius:BorderRadius.circular(12),
                          boxShadow:[
                            BoxShadow(
                              color:HexColor('303030').withOpacity(0.15),
                              spreadRadius:3,
                              blurRadius:6,
                              offset: Offset(0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child:TextFormField(
                          textInputAction: TextInputAction.done,
                          maxLines:3,
                          style:TextStyle(
                            fontFamily:kFontPoppins,
                            fontSize:13,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Any Feedback',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:Colors.transparent),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color:Colors.transparent),
                            ),
                          ),
                          textAlign: TextAlign.left,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Text is empty';
                            }
                            return null;
                          },
                        ),
                    ),
                    SizedBox(
                      height:30,
                    ),
                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisAlignment:MainAxisAlignment.end,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          color:Colors.transparent,
                          child:Text(
                            'Submit',
                            style:TextStyle(
                                color:HexColor('41CEA4'),
                                fontFamily:kFontPoppins,
                                fontWeight:FontWeight.w600,
                                fontSize:18
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(left:16,right:30),
                          child:CircleAvatar(
                              radius:25,
                              backgroundColor:HexColor('41CEA4'),
                              child:IconButton(
                                icon:Icon(
                                  Icons.arrow_forward,
                                  color:Colors.white,
                                ),
                                onPressed:() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PaymentMethod()));
                                  },
                              )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:30,
                    )
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


