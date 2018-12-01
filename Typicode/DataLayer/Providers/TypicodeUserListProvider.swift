//
//  TypicodeUserListProvider.swift
//  Typicode
//
//  Created by Lubarda, Miso on 01.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class TypicodeUserListProvider: UserListUseCase {
    private let service: HttpService

    init(service: HttpService = HttpServiceProvider(session: DataNetworkSession())) {
        self.service = service
    }

    func fetch(_ completion: @escaping (Response<Users>) -> Void) {
        guard let request = HttpRequest(endpoint: .users).urlRequest else {
            completion(.error(RequestError.urlRequestFailed))
            return
        }
        service.execute(request) { (response: Response<[TypicodeUser]>) in
            switch response {
            case let .success(userList):
                completion(.success(userList.users))
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}

struct TypicodeUser: Decodable {
    let name: String
    let username: String
    let email: String
}

extension Array where Element == TypicodeUser {
    var users: [User] {
        return map { User(name: $0.name,
                          username: $0.username,
                          email: $0.email,
                          address: "") }
    }
}
