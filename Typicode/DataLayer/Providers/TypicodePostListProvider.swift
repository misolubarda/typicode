//
//  TypicodePostListProvider.swift
//  Typicode
//
//  Created by Lubarda, Miso on 03.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class TypicodePostListProvider: PostListUseCase {
    private let service: HttpService

    init(service: HttpService = HttpServiceProvider(session: DataNetworkSession())) {
        self.service = service
    }

    func fetch(for user: User, _ completion: @escaping (Response<Posts>) -> Void) {
        guard let typicoUser = user as? TypicodeUser,
            let request = HttpRequest(endpoint: .posts(userId: String(typicoUser.id))).urlRequest else {
                completion(.error(RequestError.urlRequestFailed))
                return
        }
        service.execute(request) { (response: Response<[TypicodePost]>) in
            switch response {
            case let .success(postsList):
                completion(.success(postsList.posts))
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}

struct TypicodePost: Decodable {
    let title: String
    let body: String
}

extension Array where Element == TypicodePost {
    var posts: Posts {
        return map { Post(title: $0.title, body: $0.body) }
    }
}
