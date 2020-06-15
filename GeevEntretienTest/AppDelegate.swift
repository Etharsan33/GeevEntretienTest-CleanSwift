//
//  AppDelegate.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // if no launcher window might be nil
        if self.window == nil {
            self.window = UIWindow(frame:UIScreen.main.bounds)
        }
        
        self.window?.rootViewController = TabBarController.instance
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

