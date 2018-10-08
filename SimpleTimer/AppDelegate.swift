//
//  AppDelegate.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 04/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let presenter = TimerViewPresenter()
        let rootViewController = TimerViewController(with: presenter)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
