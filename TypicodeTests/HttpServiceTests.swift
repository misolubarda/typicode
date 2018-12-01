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

private extension URLRequest {
    static var fake: URLRequest {
        return URLRequest(url: URL(string: "http://www.something.si")!)
    }
}
