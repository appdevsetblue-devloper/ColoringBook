//
//  AppDelegate.swift
//  ColoringBook
//
//  Created by I MAC on 15/01/18.
//  Copyright © 2018 I MAC. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import UserNotifications
import Siren
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    var imgLoader:UIImageView!
    var loaderView :UIView!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.isStatusBarHidden = false
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
     
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            application.registerForRemoteNotifications()
        } else {
        
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
         }
     
        let siren = Siren.shared
//        siren.alertType = .force
//        siren.checkVersion(checkType: .immediately)
        
        return true
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    //MARK: - SHOW LOADER
    func showAppLoader(){
        
        if loaderView != nil{
            loaderView.removeFromSuperview()
        }
        loaderView = UIView(frame: CGRect(x:0,y:0,width:SCREENWIDTH(),height:SCREENHEIGHT()))
        loaderView.backgroundColor = COLOR_CUSTOM(0,0,0, 0.4)
        let viewLogoBack : UIView = UIView(frame: CGRect(x:0,y:0,width:80,height:80))
        viewLogoBack.backgroundColor = COLOR_WHITE
        viewLogoBack.center = loaderView.center
        viewLogoBack.createRectShadowWithOffset(offset: CGSize.zero, opacity: 0.5, radius: 2.0)
        viewLogoBack.setCornerRadius(radius: 8)
        imgLoader = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let images : [UIImage] = [Set_Local_Image("icon_Loader1"),
                                  Set_Local_Image("icon_Loader2"),
                                  Set_Local_Image("icon_Loader3"),
                                  Set_Local_Image("icon_Loader4"),
                                  Set_Local_Image("icon_Loader5")]
        imgLoader.animationImages = images
        imgLoader.setCornerRadius(radius: 8)
        imgLoader.animationDuration = 2
        imgLoader.center = loaderView.center
        loaderView.addSubview(viewLogoBack)
        imgLoader.animationRepeatCount = 500
        imgLoader.startAnimating()
        loaderView.addSubview(imgLoader)
        self.window?.addSubview(loaderView)
    }
    
    //MARK: - REMOVE APP LOADER
    func removeLoader() {
        if loaderView != nil {
            loaderView.removeFromSuperview()
        }
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ColoringBook")
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

    // MARK: - Core Data Saving support

    func saveContext () {
         
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func registerForPushNotifications(application: UIApplication) {
      
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
        application.registerForRemoteNotifications()
    }
    
}

