//
//  User.swift
//  Typicode
//
//  Created by Lubarda, Miso on 30.11.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

protocol User {
    var name: String { get }
    var username: String { get }
    var email: String { get }
    var address: String { get }
}

typealias Users = [User]
