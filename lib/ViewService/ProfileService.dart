


import 'package:flutter/material.dart';
import 'package:phillshoes/GlobalClasses/Constant.dart';
import 'package:phillshoes/GlobalClasses/GlobalClasses.dart';
import 'package:phillshoes/Views/Notifications.dart';
import 'package:phillshoes/Views/LoginType.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';



class ProfileService extends StatefulWidget {
  @override
  _ProfileServiceState createState() => _ProfileServiceState();
}

class _ProfileServiceState extends State<ProfileService> {
  var textName = TextEditingController();
  var textAge = TextEditingController();
  var textFrom = TextEditingController();
  var textLanguage = TextEditingController();
  var textLocalAddress = TextEditingController();

  final fireStore = Firestore.instance;
  var storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> dictUserDetails = Map<String, dynamic>();

  File _image;
  final picker = ImagePicker();

  Future openCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
      _uploadFile();
    });
  }

  Future openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() async {
      _image = File(pickedFile.path);
      _uploadFile();
    });
  }

//  List<StorageUploadTask> _tasks = <StorageUploadTask>[];

  Future<void> _uploadFile() async {
    var downloadUrl = '';

    showLoading(context);
    _auth.currentUser().then((currentUser) async {
      var ref = FirebaseStorage.instance.ref().child(kFireBaseProfilePicture).child(currentUser.email+kConnect+currentUser.uid);
      var uploadTask = ref.putFile(_image);
      var storageTaskSnapshot = await uploadTask.onComplete;
       downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      _auth.currentUser().then((currentUser) {
        var tableName = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
        fireStore.collection(tableName).document(currentUser.email+kConnect+currentUser.uid).updateData({
          kprofile:downloadUrl,
          kname:downloadUrl
        }).catchError((error) {
          print(error.toString());
          Toast.show(
              error.toString(),
              context,
              backgroundColor:Colors.red,
              duration:2
          );
        }).then((value) {
          dismissLoading(context);
          Toast.show(
              'Profile picture updated successfully.',
              context,
              backgroundColor:Colors.red,
              duration:2
          );
        });
      });
    });

  }

  _settingModalBottomSheet(context,) {
    showModalBottomSheet(
        backgroundColor:Colors.transparent,
        context: context,
        builder:(BuildContext bc) {
          return Container(
              height:280,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.only(
                    topRight:  Radius.circular(20),
                    topLeft:  Radius.circular(20)
                ),
//              border: Border.all(width:3,color: Colors.green,style: BorderStyle.solid)
              ),
              child:Center(
                child:Column(
                  children:<Widget>[
                    SizedBox(height:30),
                    Text(
                      'Please select an option',
                      style:TextStyle(
                          fontSize:18,
                          fontFamily:kFontPoppins,
                          color:HexColor(kThemeColor),
                          fontWeight:FontWeight.bold
                      ),
                    ),
                    SizedBox(height:10),
                    FlatButton(
                      child:Text(
                        'Camera',
                        style:TextStyle(
                            fontSize:16,
                            fontFamily:kFontPoppins,
                            color:HexColor(kThemeColor),
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                        openCamera();
                      },
                    ),
                    FlatButton(
                      child:Text(
                        'Galary',
                        style:TextStyle(
                            fontSize:16,
                            fontFamily:kFontPoppins,
                            color:HexColor(kThemeColor),
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                        openGallery();
                      },
                    ),
                    SizedBox(height:30,),
                    FlatButton(
                      child:Text(
                        'Cancel',
                        style:TextStyle(
                            fontSize:18,
                            fontFamily:kFontPoppins,
                            color:Colors.red,
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds:1), () {
      getData_FireBaseFireStore();
    });
    super.initState();
  }

  getData_FireBaseFireStore() async {
    showLoading(context);
    await _auth.currentUser().then((currentUser) async {
      var tableName = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
      await fireStore.collection(tableName).document(currentUser.email+kConnect+currentUser.uid).get().then((value){
        print(value.data);
        dictUserDetails = value.data;
        print(dictUserDetails);

        setState(() {
          textName.text = dictUserDetails[kname];
          textAge.text = dictUserDetails[kage]+' years';
          textFrom.text = dictUserDetails[kuser_from];
          textLanguage.text = dictUserDetails[klanguage];
          textLocalAddress.text = dictUserDetails[klocal_address];
        });
      }).catchError((error) {
        print(error.toString());
        Toast.show(
            error.toString(),
            context,
            backgroundColor:Colors.red,
            duration:2
        );
      }).then((value) {
        dismissLoading(context);
      });
    });
  }

  updateData_FireBaseFireStore() {
    showLoading(context);
    _auth.currentUser().then((currentUser) {
      var tableName = (kType == kUser) ? kFireBaseUser : kFireBaseServiceProviders;
      fireStore.collection(tableName).document(currentUser.email+kConnect+currentUser.uid).updateData({
        kname:textName.text,
        kage:textAge.text,
        kuser_from:textFrom.text,
        klanguage:textLanguage.text,
        klocal_address:textLocalAddress.text
      }).catchError((error) {
        print(error.toString());
        Toast.show(
            error.toString(),
            context,
            backgroundColor:Colors.red,
            duration:2
        );
      }).then((value) {
        dismissLoading(context);
        Toast.show(
            'Profile updated successfully',
            context,
            backgroundColor:Colors.red,
            duration:2
        );
      });
    });
  }

  /*
  get_user_profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails = json.decode(prefs.get(kUserDetails));
    List<Map<String, dynamic>> arrUserDetails = List<Map<String, dynamic>>.from(userDetails[kresult]);
    print('arrUserDetailsarrUserDetailsarrUserDetailsarrUserDetails');
    print(arrUserDetails);

    var url = kBaseURL+'get_user_profile';

    var param = {
      'user_id':'1',
      //      'user_id':arrUserDetails[0]['id'],
    };
    print(param);

    showLoading(context);
    var response = await http.post(url, body:param);
    dismissLoading(context);

    Map<String, dynamic> toJson = json.decode(response.body);
    print(toJson);

    if (toJson[kstatus] == ksuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kUserDetails,response.body);

      dictUserDetails = Map<String, dynamic>.from(toJson[kresult][0]);

      print(kBaseURLImage+dictUserDetails[kprofile]);

      setState(() {
        textName.text = dictUserDetails[kname];
        textAge.text = dictUserDetails[kage]+' years';
        textFrom.text = dictUserDetails[kuser_from];
        textLanguage.text = dictUserDetails[klanguage];
        textLocalAddress.text = dictUserDetails[klocal_address];
      });
    } else {
      Toast.show(
          toJson[kmessage].toString(),
          context,
          backgroundColor:Colors.red,
          duration:2
      );
    }

  }

  update_profile() async {
    //create multipart request for POST or PATCH method
    showLoading(context);

    var request = http.MultipartRequest("POST", Uri.parse(kBaseURL+'update_profile'));
    print(request);
    //add text fields
    request.fields['user_id'] = '1';
    request.fields['email'] = 'ronak@gmail.com';
    request.fields['mobile'] = '9782000000000';
    request.fields['name'] = textName.text;
    request.fields['age'] = textAge.text;
    request.fields['user_from'] = textFrom.text;
    request.fields['language'] = textLanguage.text;
    request.fields['local_address'] = textLocalAddress.text;

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath('file', _image.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    Map<String, dynamic> toJson = json.decode(responseString);
    print(toJson);

    dismissLoading(context);

    Toast.show(
        toJson[kmessage].toString(),
        context,
        backgroundColor:Colors.red,
        duration:2
    );

    if (toJson[kstatus] == ksuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kUserDetails,responseString);

      dictUserDetails = Map<String, dynamic>.from(toJson[kresult]);

      List<Map<String, dynamic>> arrUserDetails = [];
      arrUserDetails.add(dictUserDetails);

      setState(() {
        textName.text = dictUserDetails[kname];
        textAge.text = dictUserDetails[kage]+' years';
        textFrom.text = dictUserDetails[kuser_from];
        textLanguage.text = dictUserDetails[klanguage];
        textLocalAddress.text = dictUserDetails[klocal_address];
      });
    }

  }
*/


  @override
  Widget build(BuildContext context) {

    Size sizeScreen = MediaQuery.of(context).size;

    void showDialog() {
      showGeneralDialog(
        barrierLabel:"Barrier",
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
            position:Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child:child,
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
//                    physics:BouncingScrollPhysics(),
                    child:Column(
                      children: <Widget>[
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
                                    padding:EdgeInsets.all(0),
                                    child:Container(
                                      margin:EdgeInsets.only(top:30),
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
                                      child:ClipRRect(
                                          borderRadius:BorderRadius.circular(83),
                                          child:_image == null
                                              ? FadeInImage(
                                            fit:BoxFit.fill,
                                            height:44,
                                            width:44,
                                            image:NetworkImage(
                                                dictUserDetails[kprofile]
                                            ),
                                            placeholder:AssetImage(userPerson),
                                          )
                                              : CircleAvatar(
                                            radius:83,
                                            backgroundImage:FileImage(_image),
                                          )
                                      ),
                                    ),
                                    onPressed:() {
                                      _settingModalBottomSheet(context);
                                    },
                                  )
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height:26,
                        ),
                        Container(
                          child:Column(
                            children: <Widget>[
                              TextField(
                                controller:textName,
                                keyboardAppearance:
                                Brightness.light,
                                textAlign:TextAlign.center,
                                style:TextStyle(
                                    color:Colors.black,
                                    fontFamily:kFontPoppins,
                                    fontWeight:FontWeight.w600,
                                    fontSize:20
                                ),
                                decoration:InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical:0.0),
                                    border:InputBorder.none,
                                    hintText:'Mark Zenith'
                                ),
                              ),
                              TextField(
                                controller:textAge,
                                keyboardAppearance:
                                Brightness.light,
                                textAlign:TextAlign.center,
                                style:TextStyle(
                                    color:Colors.black,
                                    fontFamily:kFontPoppins,
                                    fontSize:14
                                ),
                                decoration:InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical:0.0),
                                  border:InputBorder.none,
                                  hintText:'2.5 years',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width:sizeScreen.width,
                          height:1,
                          color:HexColor('B6B4B4'),
                        ),
                        Container(
                            margin:EdgeInsets.only(left:0,top:10),
                            width:sizeScreen.width,
                            child:Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(width:10),
                                    Container(
                                      child:Icon(
                                        Icons.home,
                                        color:Colors.black,
                                      ),
                                    ),
                                    SizedBox(width:10),
                                    Container(
                                      width:sizeScreen.width-45,
                                      child:Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
//                                        width:sizeScreen.width,
                                            child:Text(
                                                'From,',
                                                style:TextStyle(
                                                    fontFamily:kFontPoppins,
//                                                fontWeight:FontWeight.w600,
                                                    color:Colors.black,
                                                    fontSize:14)
                                            ),
                                          ),
                                          Container(
                                            width:sizeScreen.width-110,
                                            child:TextField(
                                              controller:textFrom,
                                              keyboardAppearance:
                                              Brightness.light,
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:16
                                              ),
                                              decoration:InputDecoration(
                                                  border:InputBorder.none,
                                                  hintText:'Luck now Up'
                                              ),
                                            ),
                                          ),
//                                        SizedBox(height:20),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height:10),
                                Row(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(width:10),
                                    Container(
                                      child:Icon(
                                        Icons.language,
                                        color:Colors.black,
                                      ),
                                    ),
                                    SizedBox(width:10),
                                    Container(
                                      width:sizeScreen.width-45,
                                      child:Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
//                                        width:sizeScreen.width,
                                            child:Text(
                                                'Language,',
                                                style:TextStyle(
                                                    fontFamily:kFontPoppins,
//                                                fontWeight:FontWeight.w600,
                                                    color:Colors.black,
                                                    fontSize:14)
                                            ),
                                          ),
//                                        SizedBox(height:5),
                                          Container(
//                                      color:Colors.red,
                                            width:sizeScreen.width-110,
                                            child:TextField(
                                              controller:textLanguage,
                                              keyboardAppearance: Brightness.light,
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:16
                                              ),
                                              decoration:InputDecoration(
                                                  border:InputBorder.none,
                                                  hintText:'Knows hindi and english'
                                              ),
                                            ),
                                          ),
//                                        SizedBox(height:20),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width:sizeScreen.width,
                                  height:1,
                                  color:HexColor('B6B4B4').withOpacity(0.4),
                                ),
                                SizedBox(
                                  height:20,
                                ),
                                Row(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(width:10),
                                    Container(
                                      child:Icon(
                                        Icons.location_on,
                                        color:Colors.black,
                                      ),
                                    ),
                                    SizedBox(width:10),
                                    Container(
                                      width:sizeScreen.width-45,
                                      child:Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
//                                        width:sizeScreen.width,
                                            child:Text(
                                                'Local Address',
                                                style:TextStyle(
                                                    fontFamily:kFontPoppins,
//                                                fontWeight:FontWeight.w600,
                                                    color:Colors.black,
                                                    fontSize:14)
                                            ),
                                          ),
                                          Container(
//                                      color:Colors.red,
                                            width:sizeScreen.width-110,
                                            child:TextField(
                                              controller:textLocalAddress,
                                              keyboardAppearance:
                                              Brightness.light,
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w700,
                                                  fontSize:16
                                              ),
                                              decoration:InputDecoration(
                                                  border:InputBorder.none,
                                                  hintText:'House No. 4 Vasant Kunj'
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                        SizedBox(
                          height:16,
                        ),
                        // Badges
                        Container(
                          width:sizeScreen.width-45,
                          child:Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                                      color:Colors.red,
                                width:sizeScreen.width-110,
                                child:Text(
                                  'Badges',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w700,
                                      fontSize:16
                                  ),
                                ),
                              ),
                              SizedBox(height:16),
                              Row(
                                children: <Widget>[
                                  Visibility(
                                      visible:true,
                                      child:Container(
                                        margin:EdgeInsets.only(left:20),
                                        child:Column(
                                          children:<Widget>[
                                            Image.asset(
                                              verified,
                                              height:50,
                                            ),
                                            Text(
                                              'Verified',
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w400,
                                                  fontSize:14
                                              ),
                                            ),
                                            Text(
                                              'by Adhaar',
                                              style:TextStyle(
                                                  color:Colors.black,
                                                  fontFamily:kFontPoppins,
                                                  fontWeight:FontWeight.w400,
                                                  fontSize:14
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  Visibility(
                                    visible:true,
                                    child:Container(
                                      margin:EdgeInsets.only(left:35),
                                      child:Column(
                                        children: <Widget>[
                                          Image.asset(
                                            expert,
                                            height:50,
                                          ),
                                          Text(
                                            'Expert',
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w400,
                                                fontSize:14
                                            ),
                                          ),
                                          Text(
                                            '250 vehicles cleaned',
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w400,
                                                fontSize:14
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height:20,
                        ),
                        Container(
                          width:sizeScreen.width,
                          height:1,
                          color:HexColor('B6B4B4'),
                        ),
                        SizedBox(
                          height:30,
                        ),
                        Container(
                          width:sizeScreen.width-45,
                          child:Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width:sizeScreen.width-110,
                                child:Text(
                                  'Identified Documents:',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w700,
                                      fontSize:16
                                  ),
                                ),
                              ),
                              SizedBox(height:16),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                      width:20
                                  ),
                                  Visibility(
                                    visible:true,
                                    child:Image.asset(
                                      adhar,
                                      width:90,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.all(30),
                          child:Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height:45,
                                width:112,
                                decoration:BoxDecoration(
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
                                  boxShadow:[
                                    BoxShadow(
                                      color:HexColor('5D9FFF').withOpacity(0.5),
                                      spreadRadius:2,
                                      blurRadius:10,
                                      offset: Offset(0,10),
                                    )
                                  ],
                                ),
                                child:FlatButton(
                                  textColor:Colors.white,
                                  child:Text(
                                    'UPDATE',
                                    textAlign:TextAlign.left,
                                    style:TextStyle(
                                        color:Colors.white,
//                                        fontFamily:kFontPoppins,
                                        fontWeight:FontWeight.w700,
                                        fontSize:16
                                    ),
                                  ),
                                  onPressed:() {
                                    updateData_FireBaseFireStore();
                                  },
                                ),
                              ),
                              Row(
                                children: <Widget>[
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
                                    margin:EdgeInsets.only(left:16),
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
                                            showDialog();
                                          },
                                        )
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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

/*
class _ProfileServiceState extends State<ProfileService> {
  var textName = TextEditingController();
  var textAge = TextEditingController();
  var textFrom = TextEditingController();
  var textLanguage = TextEditingController();
  var textLocalAddress = TextEditingController();


  Map<String, dynamic> dictUserDetails = Map<String, dynamic>();

  File _image;
  final picker = ImagePicker();

  Future openCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  _settingModalBottomSheet(context,) {
    showModalBottomSheet(
        backgroundColor:Colors.transparent,
        context: context,
        builder:(BuildContext bc) {
          return Container(
              height:280,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.only(
                    topRight:  Radius.circular(20),
                    topLeft:  Radius.circular(20)
                ),
//              border: Border.all(width:3,color: Colors.green,style: BorderStyle.solid)
              ),
              child:Center(
                child:Column(
                  children:<Widget>[
                    SizedBox(height:30),
                    Text(
                      'Please select an option',
                      style:TextStyle(
                          fontSize:18,
                          fontFamily:kFontPoppins,
                          color:HexColor(kThemeColor),
                          fontWeight:FontWeight.bold
                      ),
                    ),
                    SizedBox(height:10),
                    FlatButton(
                      child:Text(
                        'Camera',
                        style:TextStyle(
                            fontSize:16,
                            fontFamily:kFontPoppins,
                            color:HexColor(kThemeColor),
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                        openCamera();
                      },
                    ),
                    FlatButton(
                      child:Text(
                        'Galary',
                        style:TextStyle(
                            fontSize:16,
                            fontFamily:kFontPoppins,
                            color:HexColor(kThemeColor),
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                        openGallery();
                      },
                    ),
                    SizedBox(height:30,),
                    FlatButton(
                      child:Text(
                        'Cancel',
                        style:TextStyle(
                            fontSize:18,
                            fontFamily:kFontPoppins,
                            color:Colors.red,
                            fontWeight:FontWeight.normal
                        ),
                      ),
                      onPressed:() {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }


  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      get_user_profile();
    });
    super.initState();
  }

  get_user_profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userDetails = json.decode(prefs.get(kUserDetails));
    List<Map<String, dynamic>> arrUserDetails = List<Map<String, dynamic>>.from(userDetails[kresult]);
    print('arrUserDetailsarrUserDetailsarrUserDetailsarrUserDetails');
    print(arrUserDetails);

    var url = kBaseURL+'get_user_profile';

    var param = {
      'user_id':'1',
      //      'user_id':arrUserDetails[0]['id'],
    };
    print(param);

    showLoading(context);
    var response = await http.post(url, body:param);
    dismissLoading(context);

    Map<String, dynamic> toJson = json.decode(response.body);
    print(toJson);

    if (toJson[kstatus] == ksuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kUserDetails,response.body);

      dictUserDetails = Map<String, dynamic>.from(toJson[kresult][0]);

      print(kBaseURLImage+dictUserDetails[kprofile]);

      setState(() {
        textName.text = dictUserDetails[kname];
        textAge.text = dictUserDetails[kage]+' years';
        textFrom.text = dictUserDetails[kuser_from];
        textLanguage.text = dictUserDetails[klanguage];
        textLocalAddress.text = dictUserDetails[klocal_address];
      });
    } else {
      Toast.show(
          toJson[kmessage].toString(),
          context,
          backgroundColor:Colors.red,
          duration:2
      );
    }

  }

  update_profile() async {
    //create multipart request for POST or PATCH method
    showLoading(context);

    var request = http.MultipartRequest("POST", Uri.parse(kBaseURL+'update_profile'));
    print(request);
    //add text fields
    request.fields['user_id'] = '1';
    request.fields['email'] = 'ronak@gmail.com';
    request.fields['mobile'] = '9782000000000';
    request.fields['name'] = textName.text;
    request.fields['age'] = textAge.text;
    request.fields['user_from'] = textFrom.text;
    request.fields['language'] = textLanguage.text;
    request.fields['local_address'] = textLocalAddress.text;

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath('file', _image.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    Map<String, dynamic> toJson = json.decode(responseString);
    print(toJson);

    dismissLoading(context);

    Toast.show(
        toJson[kmessage].toString(),
        context,
        backgroundColor:Colors.red,
        duration:2
    );

    if (toJson[kstatus] == ksuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kUserDetails,responseString);

      dictUserDetails = Map<String, dynamic>.from(toJson[kresult]);

      List<Map<String, dynamic>> arrUserDetails = [];
      arrUserDetails.add(dictUserDetails);

      setState(() {
        textName.text = dictUserDetails[kname];
        textAge.text = dictUserDetails[kage]+' years';
        textFrom.text = dictUserDetails[kuser_from];
        textLanguage.text = dictUserDetails[klanguage];
        textLocalAddress.text = dictUserDetails[klocal_address];
      });
    }

  }



  @override
  Widget build(BuildContext context) {

    Size sizeScreen = MediaQuery.of(context).size;

    void showDialog() {
      showGeneralDialog(
        barrierLabel:"Barrier",
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
            position:Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child:child,
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
                      children: <Widget>[
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
                                  padding:EdgeInsets.all(0),
                                  child:Container(
                                    margin:EdgeInsets.only(top:30),
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
                                    child:ClipRRect(
                                        borderRadius:BorderRadius.circular(83),
                                        child:_image == null
                                            ? FadeInImage(
                                                fit:BoxFit.fill,
                                                height:44,
                                                width:44,
                                                image:NetworkImage(
                                              kBaseURLImage+dictUserDetails[kprofile]
                                          ),
                                                placeholder:AssetImage(userPerson),
                                              )
                                            : CircleAvatar(
                                          radius:83,
                                          backgroundImage:FileImage(_image),
                                        )
                                    ),
                                  ),
                                  onPressed:() {
                                    _settingModalBottomSheet(context);
                                  },
                                )
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height:26,
                        ),
                        Container(
                          child:Column(
                            children: <Widget>[
                              TextField(
                                controller:textName,
                                keyboardAppearance:
                                Brightness.light,
                                textAlign:TextAlign.center,
                                style:TextStyle(
                                    color:Colors.black,
                                    fontFamily:kFontPoppins,
                                    fontWeight:FontWeight.w600,
                                    fontSize:20
                                ),
                                decoration:InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical:0.0),
                                    border:InputBorder.none,
                                    hintText:'Mark Zenith'
                                ),
                              ),
                              TextField(
                                controller:textAge,
                                keyboardAppearance:
                                Brightness.light,
                                textAlign:TextAlign.center,
                                style:TextStyle(
                                    color:Colors.black,
                                    fontFamily:kFontPoppins,
                                    fontSize:14
                                ),
                                decoration:InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical:0.0),
                                  border:InputBorder.none,
                                    hintText:'2.5 years',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width:sizeScreen.width,
                          height:1,
                          color:HexColor('B6B4B4'),
                        ),
                        Container(
                          margin:EdgeInsets.only(left:0,top:10),
                          width:sizeScreen.width,
                          child:Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width:10),
                                  Container(
                                    child:Icon(
                                      Icons.home,
                                      color:Colors.black,
                                    ),
                                  ),
                                  SizedBox(width:10),
                                  Container(
                                    width:sizeScreen.width-45,
                                    child:Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
//                                        width:sizeScreen.width,
                                          child:Text(
                                              'From,',
                                              style:TextStyle(
                                                  fontFamily:kFontPoppins,
//                                                fontWeight:FontWeight.w600,
                                                  color:Colors.black,
                                                  fontSize:14)
                                          ),
                                        ),
                                        Container(
                                          width:sizeScreen.width-110,
                                          child:TextField(
                                            controller:textFrom,
                                            keyboardAppearance:
                                            Brightness.light,
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w700,
                                                fontSize:16
                                            ),
                                            decoration:InputDecoration(
                                                border:InputBorder.none,
                                                hintText:'Luck now Up'
                                            ),
                                          ),
                                        ),
//                                        SizedBox(height:20),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height:10),
                              Row(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width:10),
                                  Container(
                                    child:Icon(
                                      Icons.language,
                                      color:Colors.black,
                                    ),
                                  ),
                                  SizedBox(width:10),
                                  Container(
                                    width:sizeScreen.width-45,
                                    child:Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
//                                        width:sizeScreen.width,
                                          child:Text(
                                              'Language,',
                                              style:TextStyle(
                                                  fontFamily:kFontPoppins,
//                                                fontWeight:FontWeight.w600,
                                                  color:Colors.black,
                                                  fontSize:14)
                                          ),
                                        ),
//                                        SizedBox(height:5),
                                        Container(
//                                      color:Colors.red,
                                          width:sizeScreen.width-110,
                                          child:TextField(
                                            controller:textLanguage,
                                            keyboardAppearance: Brightness.light,
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w700,
                                                fontSize:16
                                            ),
                                            decoration:InputDecoration(
                                                border:InputBorder.none,
                                                hintText:'Knows hindi and english'
                                            ),
                                          ),
                                        ),
//                                        SizedBox(height:20),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width:sizeScreen.width,
                                height:1,
                                color:HexColor('B6B4B4').withOpacity(0.4),
                              ),
                              SizedBox(
                                height:20,
                              ),
                              Row(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width:10),
                                  Container(
                                    child:Icon(
                                      Icons.location_on,
                                      color:Colors.black,
                                    ),
                                  ),
                                  SizedBox(width:10),
                                  Container(
                                    width:sizeScreen.width-45,
                                    child:Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
//                                        width:sizeScreen.width,
                                          child:Text(
                                              'Local Address',
                                              style:TextStyle(
                                                  fontFamily:kFontPoppins,
//                                                fontWeight:FontWeight.w600,
                                                  color:Colors.black,
                                                  fontSize:14)
                                          ),
                                        ),
                                        Container(
//                                      color:Colors.red,
                                          width:sizeScreen.width-110,
                                          child:TextField(
                                            controller:textLocalAddress,
                                            keyboardAppearance:
                                            Brightness.light,
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w700,
                                                fontSize:16
                                            ),
                                            decoration:InputDecoration(
                                                border:InputBorder.none,
                                                hintText:'House No. 4 Vasant Kunj'
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                        SizedBox(
                          height:16,
                        ),
                        // Badges
                        Container(
                          width:sizeScreen.width-45,
                          child:Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                                      color:Colors.red,
                                width:sizeScreen.width-110,
                                child:Text(
                                  'Badges',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w700,
                                      fontSize:16
                                  ),
                                ),
                              ),
                              SizedBox(height:16),
                              Row(
                                children: <Widget>[
                                  Visibility(
                                    visible:(dictUserDetails[kis_verified] == '1')
                                        ? true : false,
                                    child:Container(
                                      margin:EdgeInsets.only(left:20),
                                      child:Column(
                                        children:<Widget>[
                                          Image.asset(
                                            verified,
                                            height:50,
                                          ),
                                          Text(
                                            'Verified',
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w400,
                                                fontSize:14
                                            ),
                                          ),
                                          Text(
                                            'by Adhaar',
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w400,
                                                fontSize:14
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                  Visibility(
                                    visible:(dictUserDetails[kis_expert] == '1')
                                        ? true : false,
                                    child:Container(
                                      margin:EdgeInsets.only(left:35),
                                      child:Column(
                                        children: <Widget>[
                                          Image.asset(
                                            expert,
                                            height:50,
                                          ),
                                          Text(
                                            'Expert',
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w400,
                                                fontSize:14
                                            ),
                                          ),
                                          Text(
                                            '250 vehicles cleaned',
                                            style:TextStyle(
                                                color:Colors.black,
                                                fontFamily:kFontPoppins,
                                                fontWeight:FontWeight.w400,
                                                fontSize:14
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height:20,
                        ),
                        Container(
                          width:sizeScreen.width,
                          height:1,
                          color:HexColor('B6B4B4'),
                        ),
                        SizedBox(
                          height:30,
                        ),
                        Container(
                          width:sizeScreen.width-45,
                          child:Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width:sizeScreen.width-110,
                                child:Text(
                                  'Identified Documents:',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontFamily:kFontPoppins,
                                      fontWeight:FontWeight.w700,
                                      fontSize:16
                                  ),
                                ),
                              ),
                              SizedBox(height:16),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                      width:20
                                  ),
                                  Visibility(
                                    visible:(dictUserDetails[kis_identify] == '1')
                                        ? true : false,
                                    child:Image.asset(
                                      adhar,
                                      width:90,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.all(30),
                          child:Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: <Widget>[
                            Container(
                            height:45,
                            width:112,
                            decoration:BoxDecoration(
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
                              boxShadow:[
                                BoxShadow(
                                  color:HexColor('5D9FFF').withOpacity(0.5),
                                  spreadRadius:2,
                                  blurRadius:10,
                                  offset: Offset(0,10),
                                )
                              ],
                            ),
                            child:FlatButton(
                              textColor:Colors.white,
                              child:Text(
                                'UPDATE',
                                textAlign:TextAlign.left,
                                style:TextStyle(
                                    color:Colors.white,
//                                        fontFamily:kFontPoppins,
                                    fontWeight:FontWeight.w700,
                                    fontSize:16
                                ),
                              ),
                              onPressed:() {
                                update_profile();
                              },
                            ),
                          ),
                              Row(
                                children: <Widget>[
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
                                    margin:EdgeInsets.only(left:16),
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
                                            showDialog();
                                          },
                                        )
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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
*/