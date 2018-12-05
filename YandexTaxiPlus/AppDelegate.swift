//
//  AppDelegate.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging
import UserNotifications
import CoreLocation
import MapKit
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let gcmMessageIDKey = "gcm.message_id"
    
    var token = [String()]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Ок"
        GMSPlacesClient.provideAPIKey("AIzaSyAuSB9DXj45y7Ln8x45gTDOv-DhaFBm7Ys")
        GMSServices.provideAPIKey("AIzaSyAuSB9DXj45y7Ln8x45gTDOv-DhaFBm7Ys")
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        UINavigationBar.appearance().backgroundColor = UIColor(displayP3Red: 104/255, green: 205/255, blue: 179/255, alpha: 1.0)
        Messaging.messaging().delegate = self
        
      
        if #available(iOS 10.0, *) {
            // from github
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        if APItoken.getToken() != nil {
            
            window?.rootViewController = GetUser()

        }
        else {
            window?.rootViewController = EnterPhone()
        }
        return true
    }

    
 
    
    // Below Mehtod will print error if not able to update location.
 
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
        let dict = userInfo["aps"] as! NSDictionary
        let message = dict["alert"]
        let type = userInfo[AnyHashable("type")] as! String
 
    }

    func showAlert() {
        let objAlert = UIAlertController(title: "Alert", message: "Request authorization succeeded", preferredStyle: UIAlertController.Style.alert)
        
        objAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        //self.presentViewController(objAlert, animated: true, completion: nil)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(objAlert, animated: true, completion: nil)
    }
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "messengerdatalist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print("Push notification received: \(userInfo)")
        let type = userInfo[AnyHashable("type")] as! String
        print(type)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: type), object: nil, userInfo: userInfo)
        
        print(userInfo)
        // Print full message.
        print("userInfo is", userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        
        
        completionHandler([.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        // Print message id
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print("didReceive response: ", userInfo)
        completionHandler()
    }
}


@available(iOS 10.0, *)
extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
        print("Firebase registration token: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "pushId")
        print("sending fcm token starts")
        
        
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}



