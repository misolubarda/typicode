//
//  TypicodeUserListProviderTests.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 01.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
@testable import Typicode

class TypicodeUserListProviderTests: XCTestCase {
    private let httpServiceFake = HttpServiceFake()
    private var provider: TypicodeUserListProvider!

    override func setUp() {
        httpServiceFake.result = [TypicodeUser.fakeUser]
        provider = TypicodeUserListProvider(service: httpServiceFake)
    }

    // MARK: Request

    func test_fetch_requestHasCorrectHost() {
        provider.fetch { _ in }

        expect(self.httpServiceFake.request?.url?.host).to(equal("jsonplaceholder.typicode.com"))
    }

    func test_fetch_requestHasCorrectEndpointPath() {
        provider.fetch { _ in }

        expect(self.httpServiceFake.request?.url?.absoluteString).to(contain("users"))
    }

    // MARK: Response

    func test_fetch_onSuccessfulResponse_resultIsSuccess() {
        var success = false

        provider.fetch { response in
            switch response {
            case .success:
                success = true
            default: break
            }
        }

        expect(success).to(beTrue())
    }

    func test_fetch_dataModelIsCorrect() {
        let networkSessionFake = NetworkSessionFake()
        networkSessionFake.data = Data.users
        let httpService = HttpServiceProvider(session: networkSessionFake)
        provider = TypicodeUserListProvider(service: httpService)
        var users: Users?

        provider.fetch { response in
            switch response {
            case let .success(result):
                users = result
            default: break
            }
        }

        expect(users).notTo(beNil())
    }

    func test_fetch_onErrorResponse_resultIsError() {
        httpServiceFake.error = NSError(domain: "domain", code: 400)
        let provider = TypicodeUserListProvider(service: httpServiceFake)
        var error = false

        provider.fetch { response in
            switch response {
            case .error:
                error = true
            default: break
            }
        }

        expect(error).to(beTrue())
    }
}

private extension TypicodeUser {
    static var fakeUser: TypicodeUser {
        return TypicodeUser()
    }

    private init() {
        self.init(id: 0,
                  name: "name",
                  username: "username",
                  email: "email",
                  typicodeAddress: TypicodeAddress(street: "street1",
                                                   suite: "suite",
                                                   city: "city",
                                                   zipcode: "zipcode"))
    }
}
