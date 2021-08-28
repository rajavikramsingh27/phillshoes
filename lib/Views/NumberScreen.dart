import 'package:flutter/material.dart';

import '../GlobalClasses/Constant.dart';
import '../GlobalClasses/GlobalClasses.dart';

class NumberScreen extends StatefulWidget {
  @override
  _NumberScreenState createState() => _NumberScreenState();
}
class _NumberScreenState extends State<NumberScreen> {
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      body:SafeArea(
        child: Container(
          child:   Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 140,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: 30, right: 10),
                        height: 50,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                    Icons.call,
                                    color:
                                    HexColor('#5D9FFF'),
                                  ),
                                  height: 20,
                                ),
                                Container(
                                  width: sizeScreen.width -
                                      130,
                                  padding: EdgeInsets.only(
                                      left: 10),
                                  child: TextField(

                                    keyboardAppearance:
                                    Brightness.light,
                                    style: TextStyle(
                                      fontFamily:
                                      kFontPoppins,
                                      fontSize: 16,
                                    ),
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none,
                                        hintText:
                                        'Mobile number'),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              color: HexColor('#707070'),
                            ),
                            FlatButton(
                              textColor: Colors.white,
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: kFontRaleway,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {

                                /*         Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => OTP()));*/
                              },
                            ),
                          ],
                        )),


                    SizedBox(height: 20)


                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}