//
//  HttpServiceFake.swift
//  TypicodeTests
//
//  Created by Lubarda, Miso on 01.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
@testable import Typicode

class HttpServiceFake: HttpService {
    var request: URLRequest?
    var error: Error?
    var result: Decodable?

    func execute<T>(_ request: URLRequest, callback: @escaping (Response<T>) -> Void) where T : Decodable {
        self.request = request
        if let error = error {
            callback(.error(error))
            return
        }
        callback(.success(result as! T))
    }
}
