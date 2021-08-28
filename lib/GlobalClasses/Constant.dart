

import 'package:google_maps_flutter/google_maps_flutter.dart';


String email = '';
String fcmToken = '';

final curveBG = 'assets/curveBG.png';
final bg = 'assets/BG.png';
final logo = 'assets/Logo.png';
final cancelLight = 'assets/cancelLight.png';
final user = 'assets/user.png';
final eye = 'assets/eye.png';
final userPerson = 'assets/userPerson.jpeg';
final QR_code = 'assets/QR_code.png';
final tick = 'assets/tick.png';
final bgHalf = 'assets/bgHalf.png';
final visa = 'assets/visa.png';
final check = 'assets/check.png';
final unCheck = 'assets/unCheck.png';
final Logotype= 'assets/Logotype@3x.png';
final calendar2= 'assets/calendar2.png';
final offlineSwitch= 'assets/offline.png';
final onlineSwitch= 'assets/online.png';
final adhar= 'assets/adhar.png';
final expert= 'assets/expert.png';
final verified= 'assets/Verified.png';

final sad= 'assets/sad.png';
final angry= 'assets/angry.png';
final happy= 'assets/happy.png';
final satisfied= 'assets/satisfied.png';

final back= 'assets/back.png';
final next= 'assets/next.png';
final carDemo= 'assets/CarDemo.png';

final like = 'assets/like.png';
final time= 'assets/time.png';
final clean= 'assets/clean.png';

final bank= 'assets/bank.png';
final exchange= 'assets/exchange.png';
final coins= 'assets/coins.png';
final signBG= 'assets/signBG.png';

final kFontRaleway = "Raleway";
final kFontPoppins = "Poppins";
final kFontPTSans = "Poppins";

var kType = '';
var kUser = 'user';
var kService = 'service';
var kLocation = 'service';
var kSelectedLocation = '';
var kLocationUpdate = 'LocationUpdate';

var kIsSignUp = false;
var visibiltySearchForDest = true;
var visibiltyMyHome = false;

CameraPosition kSelectedPosition;

final kThemeColor = '#2274A0';

final kBaseURL = 'http://www.sewjaipur.com/shopbank/service/api/Api/';
final kBaseURLImage = 'http://www.sewjaipur.com/shopbank/service/uploads/';

// API response parameters

final kIcon = 'icon';

//final kUserDetails = 'userDetails';
//final kmessage = 'message';
//final kresult = 'result';
//final kstatus = 'status';
//final ksuccess = 'success';

final kid = 'id';
final kprofile = 'profile';
final kis_verified = 'is_verified';
final kis_identify = 'is_identify';
final kis_expert = 'is_expert';
final kis_online = 'is_online';
final kname = 'name';
final kemail = 'email';
final kmobile = 'mobile';
final kpassword = 'password';
final kpassword_string = 'password_string';
final kotp = 'otp';

final klatitude = 'latitude';
final klongitude = 'longitude';
final kservice_id = 'service_id';
final kservice_name = 'service_name';
final kcreated = 'created';
final kage = 'age';
final kuser_from = 'user_from';
final klanguage = 'language';
final klocal_address = 'local_address';
final kuserID = 'userID';
final kuserRole = 'userRole';
final kemail_ID = 'email_ID';
final kdevice_type = 'device_type';
final kdevice_token = 'device_token';

final kvendor_id = 'vendor_id';
final kexp_year = 'exp_year';
final kbusiness_name = 'business_name';
final kabout_business = 'about_business';
final kavg_price = 'avg_price';
final krate_card = 'rate_card';

final kUnKnownLocation = 'unKnown Location';

// FireBase parameters
final kFireBaseServerkey = 'AAAA2qI7Pq4:APA91bGxse8Whupb5vs0wYInlw-dXHLRODQs4MyXZb0DVYssacZpJH-lRHr-Fc6S2kvgIuWW3Ii30YH47ErKn4UrHORaUWxYUh2z-tXVsO23JCD0tNmUJdHz280JsyJPIR1toPC0d-U6';
final kFireBaseUser = 'users';
final kFireBaseServiceProviders = 'userProviders';
final kFireBaseServices = 'services';
final kFireBaseNotifications = 'noti_Booking_Details';
final kFireBaseProfilePicture = 'userProfilePicture/';
final kConnect = '__';
final kTitle_Notification = 'title_Notification';
final kMessage_Notification = 'message_Notification';

final kBookingIsIncoming = 'Booking is incoming...';
final kCheckYourApp = 'Check your app';



// BookingDetails
final kStatusBooking = 'status';
final kBookingID = 'bookingID';
final kStatusBookingInComing = 'InComing';
final kStatusBookingAccepted = 'Accepted';
final kStatusBookingRejected = 'Rejected';
final kStatusBookingComplete = 'Complete';
final kStatusBookingRating = 'Rating';

final kServiceProviderDetails = 'serviceProviderDetails';
final kUserDetails = 'userDetails';

const kGoogleApiKey = 'AIzaSyAAKe-aqy-ulj5Zi5xK1zAxISLJNGiwyR8'; // this is from enayat
//const kGoogleApiKey = 'AIzaSyAOziSLP3guCmX1uXdmLyulUxawcmbf3jg'; // this is from appentus


// Notification Centre


