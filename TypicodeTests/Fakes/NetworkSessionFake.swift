//
//  NetworkSessionFake.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 01.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
@testable import Typicode

class NetworkSessionFake: NetworkSession {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?

    func perform(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, urlResponse, error)
    }
}
