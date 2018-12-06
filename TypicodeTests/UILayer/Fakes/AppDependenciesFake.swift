//
//  AppDependenciesFake.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 06.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
@testable import Typicode

class AppDependenciesFake: AppCoordinatorDependencies {
    var userListUseCase: UserListUseCase = UserListUseCaseFake()
    var postListUseCase: PostListUseCase = PostListUseCaseFake()
}
