//
//  AppDelegate.swift
//  Typicode
//
//  Created by Lubarda, Miso on 30.11.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: AppCoordinator!
    private let appDependencies = AppDependencies()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator = AppCoordinator(dependencies: appDependencies)
        appCoordinator.start()
        return true
    }
}

