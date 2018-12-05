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
    func userListDataSourceDidFail()
    func userListDataSourceDidSelect(_ user: User)
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
                self?.users = []
                self?.delegate?.userListDataSourceDidFail()
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
            userListCell.setup(withName: user.name, username: user.username, email: user.email, address: user.address)
        }
        return cell
    }
}

extension UserListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        delegate?.userListDataSourceDidSelect(user)
    }
}
