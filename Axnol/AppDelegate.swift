//
//  AppDelegate.swift
//  Axnol
//
//  Created by TORVIS on 21/01/21.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       //        let frontVc  = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
       //        let navigationController = UINavigationController(rootViewController: frontVc)
               let leftVc = storyboard.instantiateViewController(withIdentifier: "SideMenuTableVC")
               let mainRevealController = SWRevealViewController()
       //        mainRevealController.frontViewController = navigationController
               mainRevealController.rearViewController = leftVc
               self.window?.rootViewController = mainRevealController
               self.window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        IQKeyboardManager.shared.enable = true
        
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

