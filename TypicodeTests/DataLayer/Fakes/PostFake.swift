//
//  PostFake.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 06.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
@testable import Typicode

extension TypicodePost {
    static var postFake: TypicodePost {
        return TypicodePost()
    }

    private init() {
        self.init(title: "some title", body: "some body")
    }
}

extension Data {
    static var posts: Data {
        return """
            [
            \(postString),
            \(postString),
            \(postString)
            ]
            """.data(using: .utf8)!
    }

    private static var postString: String {
        return """
            {
                "userId": 1,
                "id": 1,
                "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto"
            }
        """
    }
}
