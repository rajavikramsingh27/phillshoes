

import UIKit
import Flutter
import GoogleMaps
import Firebase

let googleAPIKey = "AIzaSyAOziSLP3guCmX1uXdmLyulUxawcmbf3jg" // this is from appentus
//let googleAPIKey = "AIzaSyAAKe-aqy-ulj5Zi5xK1zAxISLJNGiwyR8" // this is from enayat



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey(googleAPIKey)
    FirebaseApp.configure()
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
