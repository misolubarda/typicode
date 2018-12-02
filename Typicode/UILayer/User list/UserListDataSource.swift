//
//  UserListDataSource.swift
//  Typicode
//
//  Created by Lubarda, Miso on 02.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol UserListDataSourceDependencies {
    var userListUseCase: UserListUseCase { get }
}

class UserListDataSource: NSObject {
    private let cellIdentifier: String
    private let dependencies: UserListDataSourceDependencies

    init(cellIdentifier: String, dependencies: UserListDataSourceDependencies) {
        self.cellIdentifier = cellIdentifier
        self.dependencies = dependencies
    }

    func fetch() {
        dependencies.userListUseCase.fetch { response in

        }
    }
}

extension UserListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
}
