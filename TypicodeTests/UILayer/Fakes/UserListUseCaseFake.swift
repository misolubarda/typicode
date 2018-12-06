//
//  UserListUseCaseFake.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 06.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
@testable import Typicode

class UserListUseCaseFake: UserListUseCase {
    var users: Users = [TypicodeUser.fakeUser]
    var error: Error?

    func fetch(_ completion: @escaping (Response<Users>) -> Void) {
        if let error = error {
            completion(.error(error))
        } else {
            completion(.success(users))
        }
    }
}
