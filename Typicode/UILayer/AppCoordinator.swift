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
        window.rootViewController = userListVC
        window.makeKeyAndVisible()
    }

    private var userListVC: UserListViewController {
        let userListVC = UserListViewController(dependencies: dependencies)
        userListVC.delegate = self
        return userListVC
    }
}

extension AppCoordinator: UserListViewControllerDelegate {
    func userListViewControllerDidSelect(_ user: User) {

    }
}
