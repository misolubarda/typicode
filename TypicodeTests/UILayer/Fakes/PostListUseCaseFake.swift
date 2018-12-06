//
//  PostListUseCaseFake.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 06.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
@testable import Typicode

class PostListUseCaseFake: PostListUseCase {
    var posts: Posts = [Post(title: "title", body: "body")]
    var error: Error?

    func fetch(for user: User, _ completion: @escaping (Response<Posts>) -> Void) {
        if let error = error {
            completion(.error(error))
        } else {
            completion(.success(posts))
        }
    }
}
