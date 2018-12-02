//
//  UserListViewController.swift
//  Typicode
//
//  Created by Lubarda, Miso on 02.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let dataSource: UserListDataSource
    private let userListCellIdentifier = "userListCellIdentifier"

    init() {
        dataSource = UserListDataSource(cellIdentifier: userListCellIdentifier)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
    }

    private func setupTable() {
        tableView.register(UINib(nibName: "UserListCell", bundle: nil), forCellReuseIdentifier: userListCellIdentifier)
        tableView.dataSource = dataSource
    }
}
