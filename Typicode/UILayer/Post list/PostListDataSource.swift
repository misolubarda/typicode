//
//  PostListDataSource.swift
//  Typicode
//
//  Created by Lubarda, Miso on 04.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol PostListDataSourceFeedback: class {
    func postListDataSourceDidUpdate()
}

protocol PostListDataSourceDependencies {
    var postListUseCase: PostListUseCase { get }
}

class PostListDataSource: NSObject {
    weak var delegate: PostListDataSourceFeedback?
    private let cellIdentifier: String
    private let user: User
    private let dependencies: PostListDataSourceDependencies
    private var posts = Posts()

    init(cellIdentifier: String, user: User, dependencies: PostListDataSourceDependencies) {
        self.user = user
        self.cellIdentifier = cellIdentifier
        self.dependencies = dependencies
    }

    func fetch() {
        dependencies.postListUseCase.fetch(for: user) { [weak self] response in
            switch response {
            case let .success(posts):
                self?.posts = posts
                self?.delegate?.postListDataSourceDidUpdate()
            case .error:
                break
            }
        }
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
