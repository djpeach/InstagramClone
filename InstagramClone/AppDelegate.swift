//
//  AppDelegate.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/5/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // MARK: Window Creation
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Set the rootViewController to our custom MainTabBarController
        window?.rootViewController = MainTabBarController()
        
        attemptRegisterForNotifications(application: application)
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        if let followerId = userInfo["followerId"] as? String {
            print(followerId)
            let userProfileController = UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
            userProfileController.userId = followerId
            
            if let mainTabBarController = window?.rootViewController as? MainTabBarController {
                mainTabBarController.selectedIndex = 0
                mainTabBarController.presentingViewController?.dismiss(animated: true, completion: nil)
                if let homeNavigationController = mainTabBarController.viewControllers?.first as? UINavigationController {
                    homeNavigationController.pushViewController(userProfileController, animated: true)
                }
            }
        }
    }
    
    fileprivate func attemptRegisterForNotifications(application: UIApplication) {
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, err) in
            if let err = err {
                print("Failed to request auth: \(err)")
                return
            }
            
            if granted {
                print("Auth granted")
            } else {
                print("Auth denied")
            }
        }
        
        application.registerForRemoteNotifications()
    
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Registered with FCM token: ", fcmToken)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registered for notifications: \(deviceToken)")
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

