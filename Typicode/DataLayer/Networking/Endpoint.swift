//
//  Endpoint.swift
//  Typicode
//
//  Created by Lubarda, Miso on 30.11.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

enum Endpoint {
    case users, posts(userId: String)

    var path: String {
        switch self {
        case .users:
            return "users"
        case let .posts(userId):
            return "posts?userId=\(userId)"
        }
    }
}
