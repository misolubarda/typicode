//
//  AppCoordinatorTests.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 06.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

import XCTest
import Nimble
@testable import Typicode

class AppCoordinatorTests: XCTestCase {
    let window = UIWindow()
    let userListUseCaseFake = UserListUseCaseFake()
    let postListUseCaseFake = PostListUseCaseFake()
    var coordinator: AppCoordinator!

    override func setUp() {
        let dependencies = AppDependenciesFake()
        dependencies.userListUseCase = userListUseCaseFake
        dependencies.postListUseCase = postListUseCaseFake
        coordinator = AppCoordinator(window: window, dependencies: dependencies)
        coordinator.isAnimating = false
        coordinator.start()
    }

    func test_start_windowRootVCIsNavigationController() {
        expect(self.navigation.topViewController).to(beAnInstanceOf(UserListViewController.self))
    }

    func test_onUserListError_alertIsPresented() {
        userListUseCaseFake.error = NSError(domain: "", code: 400)

        let userListVC: UserListViewController = topViewController()
        _ = userListVC.view

        expect(self.navigation.topViewController?.presentedViewController).to(beAnInstanceOf(UIAlertController.self))
    }

    func test_onUserListSuccess_alertIsNotPresented() {
        let userListVC: UserListViewController = topViewController()
        _ = userListVC.view

        expect(self.navigation.topViewController?.presentedViewController).to(beNil())
    }

    func test_onUserListSelection_presentPostList() {
        selectFirstUserCell()

        expect(self.navigation.topViewController).to(beAnInstanceOf(PostListViewController.self))
    }

    func test_onPostListError_alertIsPresented() {
        postListUseCaseFake.error = NSError(domain: "", code: 400)
        selectFirstUserCell()

        let postListVC: PostListViewController = topViewController()
        _ = postListVC.view

        expect(self.navigation.topViewController?.presentedViewController).to(beAnInstanceOf(UIAlertController.self))
    }

    func test_onPostListSuccess_alertIsNotPresented() {
        selectFirstUserCell()

        let postListVC: PostListViewController = topViewController()
        _ = postListVC.view

        expect(self.navigation.topViewController?.presentedViewController).to(beNil())
    }
}

extension AppCoordinatorTests {
    var navigation: UINavigationController {
        return window.rootViewController as! UINavigationController
    }

    func topViewController<T>() -> T {
        return navigation.topViewController as! T
    }

    func selectFirstUserCell() {
        let userListVC: UserListViewController = topViewController()
        _ = userListVC.view
        userListVC.selectFirstCell()
    }
}

private extension UserListViewController {
    func selectFirstCell() {
        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
}
