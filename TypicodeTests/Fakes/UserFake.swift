//
//  UserFake.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 01.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

extension Data {
    static var users: Data {
        return """
        [
            \(userString),
            \(userString),
            \(userString)
        ]
        """.data(using: .utf8)!
    }

    static var user: Data {
        return userString.data(using: .utf8)!
    }

    static var userWithMissingData: Data {
        return """
        {
            "name": "Leanne Graham",
            "username": "Bret",
            "email": "Sincere@april.biz"
        }
        """.data(using: .utf8)!
    }

    var decodedUser: UserFake {
        return try! JSONDecoder().decode(UserFake.self, from: self)
    }

    private static var userString: String {
        return """
        {
            "id": 1,
            "name": "Leanne Graham",
            "username": "Bret",
            "email": "Sincere@april.biz",
            "address": {
              "street": "Kulas Light",
              "suite": "Apt. 556",
              "city": "Gwenborough",
              "zipcode": "92998-3874"
            },
            "phone": "1-770-736-8031 x56442",
            "website": "hildegard.org",
            "company": {
              "name": "Romaguera-Crona",
              "catchPhrase": "Multi-layered client-server neural-net",
              "bs": "harness real-time e-markets"
            }
        }
        """
    }
}

struct UserFake: Decodable, Equatable {
    let name: String
    let username: String
    let email: String
    let address: [String: String]
}
