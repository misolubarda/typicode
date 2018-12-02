//
//  AppCoordinator.swift
//  Typicode
//
//  Created by Lubarda, Miso on 30.11.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class AppCoordinator {
    let window: UIWindow

    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }

    func start() {
        let userListVC = UserListViewController()
        window.rootViewController = userListVC
        window.makeKeyAndVisible()
    }
}
