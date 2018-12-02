//
//  AppCoordinator.swift
//  Typicode
//
//  Created by Lubarda, Miso on 30.11.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol AppCoordinatorDependencies: UserListViewControllerDependencies {}

class AppCoordinator {
    let window: UIWindow
    private let dependencies: AppCoordinatorDependencies

    init(dependencies: AppCoordinatorDependencies) {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.dependencies = dependencies
    }

    func start() {
        let userListVC = UserListViewController(dependencies: dependencies)
        window.rootViewController = userListVC
        window.makeKeyAndVisible()
    }
}
