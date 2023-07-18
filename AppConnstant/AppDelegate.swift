//
//  AppDelegate.swift
//  PRToast
//
//  Created by Spectus Infotech on 18/07/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootWindow : UIWindow {
        get {
            return UIApplication.shared.windows[0]
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

}

