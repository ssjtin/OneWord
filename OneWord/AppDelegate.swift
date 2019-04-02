//
//  AppDelegate.swift
//  OneWord
//
//  Created by Hoang Luong on 25/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainViewController()
        
        if UserDefaults.standard.value(forKey: "initialSetupComplete") == nil {
            setupUserDefault()
        }
        
        return true
    }
    
    func setupUserDefault() {
        UserDefaults.standard.setValue(5.0, forKey: Setting.MinimumLetters.rawValue)
        UserDefaults.standard.setValue(10.0, forKey: Setting.MaximumLetters.rawValue)
        UserDefaults.standard.setValue(5.0, forKey: Setting.MinimumFrequency.rawValue)
        UserDefaults.standard.setValue(6.5, forKey: Setting.MaximumFrequency.rawValue)
        UserDefaults.standard.setValue(true, forKey: "initialSetupComplete")
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}

