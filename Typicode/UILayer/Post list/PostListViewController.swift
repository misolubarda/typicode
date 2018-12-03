//
//  PostListViewController.swift
//  Typicode
//
//  Created by Lubarda, Miso on 03.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController {
    private let user: User

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = user.name
    }
}
