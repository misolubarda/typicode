//
//  UserListViewController.swift
//  Typicode
//
//  Created by Lubarda, Miso on 02.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol UserListViewControllerDelegate: class {
    func userListViewControllerDidFail(_ vc: UserListViewController)
    func userListViewControllerDidSelect(_ user: User)
}

protocol UserListViewControllerDependencies: UserListDataSourceDependencies {}

class UserListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: ActivityIndicatorView!

    weak var delegate: UserListViewControllerDelegate?
    private let dataSource: UserListDataSource
    private let userListCellIdentifier = "userListCellIdentifier"

    init(dependencies: UserListViewControllerDependencies) {
        dataSource = UserListDataSource(cellIdentifier: userListCellIdentifier, dependencies: dependencies)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        fetch()
    }

    func fetch() {
        dataSource.fetch()
        activityIndicatorView.isHidden = false
    }

    private func updateUI() {
        tableView.reloadData()
        activityIndicatorView.isHidden = true
    }

    private func setupTable() {
        tableView.register(UINib(nibName: "UserListCell", bundle: nil), forCellReuseIdentifier: userListCellIdentifier)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.tableFooterView = UIView(frame: .zero)
        dataSource.delegate = self
    }
}

extension UserListViewController: UserListDataSourceFeedback {
    func userListDataSourceDidUpdate() {
        updateUI()
    }

    func userListDataSourceDidFail() {
        updateUI()
        delegate?.userListViewControllerDidFail(self)
    }

    func userListDataSourceDidSelect(_ user: User) {
        delegate?.userListViewControllerDidSelect(user)
    }
}
