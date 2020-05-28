//
//  AppDelegate.swift
//  Xtgrams
//
//  Created by Kevinho Morales on 9/25/19.
//  Copyright © 2019 Kevinho Morales. All rights reserved.
//


import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //    Tutorial
        let defaults = UserDefaults.standard
        let skipTutorialPages = defaults.bool(forKey: "skipTutorialPages")
        
        if skipTutorialPages
        {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let nextView: NavigationStart = mainStoryboard.instantiateViewController(withIdentifier: "NavigationID") as! NavigationStart
            
            window?.rootViewController = nextView
            
        } else {
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.white
        }
        //    Tutorial
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


//import UIKit
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    
//    var window: UIWindow?
//    
//    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        
//        
////        //    Tutorial
////        let defaults = UserDefaults.standard
////        let skipTutorialPages = defaults.bool(forKey: "skipTutorialPages")
////
////        if skipTutorialPages
////        {
////            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////
////            let nextView: Navigation = mainStoryboard.instantiateViewController(withIdentifier: "navigationID") as! Navigation
////
////            window?.rootViewController = nextView
////
////        } else {
////            UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
////            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.red
////        }
////        //    Tutorial
//        
//        
//        return true
//    }
//    
//    
//    func applicationWillResignActive(_ application: UIApplication) {
//        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    }
//    
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    }
//    
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    }
//    
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }
//    
//    func applicationWillTerminate(_ application: UIApplication) {
//        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    }
//    
//    
//}

