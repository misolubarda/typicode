//
//  HTTPRequest.swift
//  Typicode
//
//  Created by Lubarda, Miso on 30.11.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

struct HttpRequest {
    let baseUrlString = "https://jsonplaceholder.typicode.com"
    let endpoint: Endpoint

    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }

    var urlRequest: URLRequest? {
        let urlString = baseUrlString + "/" + endpoint.path
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
}

enum RequestError: Error {
    case urlRequestFailed
}
