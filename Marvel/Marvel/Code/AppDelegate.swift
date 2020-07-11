//
//  AppDelegate.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import UIKit
import SwiftMessageBar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = SwiftMessageBar.Config.Builder()
            .withErrorColor(.systemYellow)
            .withTitleColor(.black)
            .withMessageColor(.black)
            .build()
        SwiftMessageBar.setSharedConfig(config)

        return true
    }

}

