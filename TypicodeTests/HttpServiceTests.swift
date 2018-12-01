//
//  HttpServiceTests.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 30.11.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

import XCTest
import Nimble
@testable import Typicode

class HttpServiceTests: XCTestCase {
    func test_execute_respondsWithTheObject() {
        let sessionFake = NetworkSessionFake()
        let userData = Data.user
        sessionFake.data = userData
        let service = HttpServiceProvider(session: sessionFake)
        var result: UserFake?

        service.execute(URLRequest.fake) { (response: Response<UserFake>) in
            switch response {
            case let .success(user):
                result = user
            default: break
            }
        }

        expect(result).to(equal(userData.decodedUser))
    }

    func test_execute_onError_returnsError() {
        let sessionFake = NetworkSessionFake()
        sessionFake.error = NSError(domain: "someDomain", code: 400, userInfo: nil)
        let service = HttpServiceProvider(session: sessionFake)
        var error: Bool?

        service.execute(URLRequest.fake) { (response: Response<UserFake>) in
            switch response {
            case .error:
                error = true
            default: break
            }
        }

        expect(error).to(beTrue())
    }

    func test_execute_onDataNotParsable_returnsDecodingError() {
        let sessionFake = NetworkSessionFake()
        sessionFake.data = Data.userWithMissingData
        let service = HttpServiceProvider(session: sessionFake)
        var result: Error?

        service.execute(URLRequest.fake) { (response: Response<UserFake>) in
            switch response {
            case let .error(error):
                result = error
            default: break
            }
        }

        expect(result).to(beAnInstanceOf(DecodingError.self))
    }

    func test_execute_onNoErrorNorData_returnsSpecificError() {
        let sessionFake = NetworkSessionFake()
        let service = HttpServiceProvider(session: sessionFake)
        var result: Error?

        service.execute(URLRequest.fake) { (response: Response<UserFake>) in
            switch response {
            case let .error(error):
                result = error
            default: break
            }
        }

        expect(result).to(beAnInstanceOf(WebServiceError.self))
    }
}

private extension Data {
    static var user: Data {
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
        """.data(using: .utf8)!
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
}

struct UserFake: Decodable, Equatable {
    let name: String
    let username: String
    let email: String
    let address: [String: String]
}

private extension URLRequest {
    static var fake: URLRequest {
        return URLRequest(url: URL(string: "http://www.something.si")!)
    }
}
