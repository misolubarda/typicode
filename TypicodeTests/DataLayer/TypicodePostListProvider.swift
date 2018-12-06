//
//  TypicodePostListProvider.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 06.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
@testable import Typicode

class TypicodePostListProviderTests: XCTestCase {
    private let httpServiceFake = HttpServiceFake()
    private var provider: TypicodePostListProvider!
    private let userFake = TypicodeUser.fakeUser

    override func setUp() {
        httpServiceFake.result = [TypicodePost.postFake]
        provider = TypicodePostListProvider(service: httpServiceFake)
    }

    // MARK: Request

    func test_fetch_requestHasCorrectHost() {
        provider.fetch(for: userFake) { _ in }

        expect(self.httpServiceFake.request?.url?.host).to(equal("jsonplaceholder.typicode.com"))
    }

    func test_fetch_requestHasCorrectEndpointPath() {
        provider.fetch(for: userFake) { _ in }

        expect(self.httpServiceFake.request?.url?.absoluteString).to(contain("posts"))
    }

    func test_fetch_requestHasCorrectUrlParameters() {
        provider.fetch(for: userFake) { _ in }

        expect(self.httpServiceFake.request?.url?.absoluteString).to(contain("?userId=0"))
    }

    // MARK: Response

    func test_fetch_onSuccessfulResponse_resultIsSuccess() {
        var success = false

        provider.fetch(for: userFake) { response in
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
        networkSessionFake.data = Data.posts
        let httpService = HttpServiceProvider(session: networkSessionFake)
        provider = TypicodePostListProvider(service: httpService)
        var posts: Posts?

        provider.fetch(for: userFake) { response in
            switch response {
            case let .success(result):
                posts = result
            default: break
            }
        }

        expect(posts).to(haveCount(3))
    }

    func test_fetch_onErrorResponse_resultIsError() {
        httpServiceFake.error = NSError(domain: "domain", code: 400)
        let provider = TypicodePostListProvider(service: httpServiceFake)
        var error = false

        provider.fetch(for: userFake) { response in
            switch response {
            case .error:
                error = true
            default: break
            }
        }

        expect(error).to(beTrue())
    }
}
