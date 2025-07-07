import Flutter
import UIKit
// import Firebase
// import FirebaseMessaging
// import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


// @UIApplicationMain
// class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

//   func application(_ application: UIApplication,
//                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//     FirebaseApp.configure()

//     UNUserNotificationCenter.current().delegate = self

//     Messaging.messaging().delegate = self

//     UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//       print("Permission granted: \(granted)")
//     }

//     application.registerForRemoteNotifications()

//     return true
//   }

//   // This method will be called when app receives push in foreground
//   func userNotificationCenter(_ center: UNUserNotificationCenter,
//       willPresent notification: UNNotification,
//       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//     completionHandler([.alert, .badge, .sound])
//   }
// }
