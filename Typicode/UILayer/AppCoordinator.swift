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

    var isAnimating = true

    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds), dependencies: AppCoordinatorDependencies) {
        self.window = window
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
        navigation.pushViewController(postListVC, animated: isAnimating)
    }
}

extension AppCoordinator: UserListViewControllerDelegate {
    func userListViewControllerDidSelect(_ user: User) {
        presentPostList(for: user)
    }

    func userListViewControllerDidFail(_ vc: UserListViewController) {
        let alertVC = UIAlertController.fetchDataErrorAlert { _ in vc.fetch() }
        vc.present(alertVC, animated: isAnimating)
    }
}

extension AppCoordinator: PostListViewControllerDelegate {
    func postListViewControllerDidFail(_ vc: PostListViewController) {
        let alertVC = UIAlertController.fetchDataErrorAlert { _ in vc.fetch() }
        vc.present(alertVC, animated: isAnimating)
    }
}
