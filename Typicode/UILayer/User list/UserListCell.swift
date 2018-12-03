//
//  UserListCell.swift
//  Typicode
//
//  Created by Lubarda, Miso on 02.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        usernameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        emailLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        addressLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    }

    func setup(withName name: String, username: String, email: String, address: String) {
        self.nameLabel.text = name
        self.usernameLabel.text = username
        self.emailLabel.text = email
        self.addressLabel.text = address
    }
}
