//
//  PostListViewController.swift
//  Typicode
//
//  Created by Lubarda, Miso on 03.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol PostListViewControllerDependencies: PostListDataSourceDependencies {}

class PostListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let dataSource: PostListDataSource
    private let postListCellIdentifier = "postListCellIdentifier"
    private let user: User

    init(user: User, dependencies: PostListViewControllerDependencies) {
        dataSource = PostListDataSource(cellIdentifier: postListCellIdentifier, user: user, dependencies: dependencies)
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = user.name
        setupTable()
    }

    private func setupTable() {
        tableView.dataSource = dataSource
    }
}
