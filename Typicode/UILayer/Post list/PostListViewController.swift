//
//  PostListViewController.swift
//  Typicode
//
//  Created by Lubarda, Miso on 03.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol PostListViewControllerDelegate: class {
    func postListViewControllerDidFail(_ vc: PostListViewController)
}

protocol PostListViewControllerDependencies: PostListDataSourceDependencies {}

class PostListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: ActivityIndicatorView!

    weak var delegate: PostListViewControllerDelegate?
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
        fetch()
    }

    private func fetch() {
        dataSource.fetch()
        activityIndicatorView.isHidden = false
    }

    private func updateUI() {
        tableView.reloadData()
        activityIndicatorView.isHidden = true
    }

    private func setupTable() {
        tableView.register(UINib(nibName: "PostListCell", bundle: nil), forCellReuseIdentifier: postListCellIdentifier)
        tableView.dataSource = dataSource
        dataSource.delegate = self
    }
}

extension PostListViewController: PostListDataSourceFeedback {
    func postListDataSourceDidUpdate() {
        updateUI()
    }

    func postListDataSourceDidFail() {
        updateUI()
        delegate?.postListViewControllerDidFail(self)
    }
}
