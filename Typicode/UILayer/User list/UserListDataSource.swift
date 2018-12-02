//
//  UserListDataSource.swift
//  Typicode
//
//  Created by Lubarda, Miso on 02.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol UserListDataSourceFeedback: class {
    func userListDataSourceDidUpdate()
}

protocol UserListDataSourceDependencies {
    var userListUseCase: UserListUseCase { get }
}

class UserListDataSource: NSObject {
    weak var delegate: UserListDataSourceFeedback?
    private let cellIdentifier: String
    private let dependencies: UserListDataSourceDependencies
    private var users = Users()

    init(cellIdentifier: String, dependencies: UserListDataSourceDependencies) {
        self.cellIdentifier = cellIdentifier
        self.dependencies = dependencies
    }

    func fetch() {
        dependencies.userListUseCase.fetch { [weak self] response in
            switch response {
            case let .success(users):
                self?.users = users
                self?.delegate?.userListDataSourceDidUpdate()
            case .error:
                break
            }
        }
    }
}

extension UserListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let userListCell = cell as? UserListCell {
            let user = users[indexPath.row]
            userListCell.setup(withName: user.name)
        }
        return cell
    }
}
