//
//  UserListUseCase.swift
//  Typicode
//
//  Created by Lubarda, Miso on 01.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

protocol UserListUseCase {
    func fetch(_ completion: @escaping (Response<Users>) -> Void)
}
