//
//  PostListUseCase.swift
//  Typicode
//
//  Created by Lubarda, Miso on 03.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

protocol PostListUseCase {
    func fetch(for user: User, _ completion: @escaping (Response<Posts>) -> Void)
}
