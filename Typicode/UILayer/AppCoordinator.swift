//
//  AppCoordinator.swift
//  Typicode
//
//  Created by Lubarda, Miso on 30.11.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol AppCoordinatorDependencies: UserListViewControllerDependencies, PostListViewControllerDependencies {}

class AppCoordinator {
    let window: UIWindow
    let navigation = UINavigationController()
    private let dependencies: AppCoordinatorDependencies

    init(dependencies: AppCoordinatorDependencies) {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.dependencies = dependencies
    }

    func start() {
        window.rootViewController = navigation
        navigation.pushViewController(userListVC, animated: false)
        window.makeKeyAndVisible()
    }

    private var userListVC: UserListViewController {
        let userListVC = UserListViewController(dependencies: dependencies)
        userListVC.delegate = self
        return userListVC
    }

    private func presentPostList(for user: User) {
        let postListVC = PostListViewController(user: user, dependencies: dependencies)
        postListVC.delegate = self
        navigation.pushViewController(postListVC, animated: true)
    }
}

extension AppCoordinator: UserListViewControllerDelegate {
    func userListViewControllerDidSelect(_ user: User) {
        presentPostList(for: user)
    }

    func userListViewControllerDidFail(_ vc: UserListViewController) {
        vc.present(UIAlertController.fetchDataErrorAlert, animated: true)
    }
}

extension AppCoordinator: PostListViewControllerDelegate {
    func postListViewControllerDidFail(_ vc: PostListViewController) {
        vc.present(UIAlertController.fetchDataErrorAlert, animated: true)
    }
}
