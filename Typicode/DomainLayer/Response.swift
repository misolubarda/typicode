//
//  Response.swift
//  Typicode
//
//  Created by Lubarda, Miso on 30.11.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T)
    case error(Error)
}
