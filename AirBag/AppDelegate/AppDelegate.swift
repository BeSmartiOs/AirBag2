//
//  AppDelegate.swift
//  AirBag
//
//  Created by Geek on 8/15/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    var navController: UINavigationController?
    var tabController: UITabBarController?
      var viewController: UIViewController?
    let userDefaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        
        if #available(iOS 10, *) {
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
        NotificationCenter.default.addObserver(forName: NSNotification.Name.InstanceIDTokenRefresh, object: nil, queue: nil, using: tokenRefreshNotification(_:))
        checkLogin()
       
        return true
    }

    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        let fireBaseToken = fcmToken
        let defaults = UserDefaults.standard
        defaults.set(fireBaseToken, forKey: "fireBaseTokenUserDefaults")
        
        // TODO: If necessary send token to applic ation server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    func tokenRefreshNotification(_ notification: Notification) {
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                let token  = "Remote InstanceID token: \(result.token)"
                  UserDefaults.standard.set(token, forKey: "fireBaseTokenUserDefaults")
                self.connectToFcm()
            }
        }
    }
    
    func connectToFcm()
    {
        Messaging.messaging().shouldEstablishDirectChannel = true
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                print("DCS:--------->>>>> " + result.token)
            }
        }
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
    
    //MARK:- Callback Funcs
    func setUpNavigationController(){
        //Image Background Navigation Bar
        let navBackgroundImage:UIImage! = UIImage(named: "them_header.png")
        UINavigationBar.appearance().setBackgroundImage(navBackgroundImage, for: .default)
    }
    func checkLogin(){
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
                
                
            } else {
                print("you're logged in")
                
                let decoded  = userDefaults.object(forKey: "logResp") as! Data
                let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! LoginContentt
                print("access token ---> \(decodedUser.token ?? "")")
                print("current type id---> \(decodedUser.currentTypeId ?? 0)")
                
                /*
                 static let carrier = 1
                 static let sender = 2
                 static let reciever = 3
                 */
                
                
                if(decodedUser.active == 3){
                if(decodedUser.currentTypeId == 1){
                    let myStoryboard = UIStoryboard(name : Constants.StroyBoards.carrierStoryBoard, bundle: nil) as UIStoryboard
                    self.tabController = myStoryboard.instantiateViewController(withIdentifier: "CarrierMainViewController") as? CarrierMainViewController
                }else  if(decodedUser.currentTypeId == 2){
                    let myStoryboard = UIStoryboard(name: Constants.StroyBoards.senderStoryBoard, bundle: nil) as UIStoryboard
                    self.tabController = myStoryboard.instantiateViewController(withIdentifier: "SenderViewController") as? SenderViewController
                }else if(decodedUser.currentTypeId == 3){
                    let myStoryboard = UIStoryboard(name: Constants.StroyBoards.recieverStoryBoard, bundle: nil) as UIStoryboard
                    self.tabController = myStoryboard.instantiateViewController(withIdentifier: "RecieverViewController") as? RecieverViewController
                }
               
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = self.tabController
                appDelegate.window?.makeKeyAndVisible()
               
                    /*
                     
                     active states:
                     0- just registered
                     1- only mobile activation is done
                     2- only email activation is done
                     */
                }else  if(decodedUser.currentTypeId == 2){
                    let myStoryboard = UIStoryboard(name : Constants.StroyBoards.mainStoryBoard, bundle: nil) as UIStoryboard
                    self.viewController = myStoryboard.instantiateViewController(withIdentifier: "VerifyNumberViewController") as? VerifyNumberViewController
                }
            }
        }
        
    }

}

