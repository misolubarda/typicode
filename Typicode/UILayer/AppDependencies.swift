//
//  AppDependencies.swift
//  Typicode
//
//  Created by Lubarda, Miso on 02.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class AppDependencies: AppCoordinatorDependencies {
    var userListUseCase: UserListUseCase = TypicodeUserListProvider()
    var postListUseCase: PostListUseCase = TypicodePostListProvider()
}
