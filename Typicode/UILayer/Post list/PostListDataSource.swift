//
//  PostListDataSource.swift
//  Typicode
//
//  Created by Lubarda, Miso on 04.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class PostListDataSource: NSObject {
    private let cellIdentifier: String
    private let user: User
    private var posts = Posts()

    init(cellIdentifier: String, user: User) {
        self.user = user
        self.cellIdentifier = cellIdentifier
    }
}

extension PostListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
