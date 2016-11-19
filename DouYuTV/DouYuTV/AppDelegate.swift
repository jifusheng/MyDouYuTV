//
//  AppDelegate.swift
//  DouYuTV
//
//  Created by 季伏生 on 2016/10/20.
//  Copyright © 2016年 jifusheng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//${SRCROOT}/Pods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orange
        application.statusBarStyle = .lightContent
        return true
    }


}

