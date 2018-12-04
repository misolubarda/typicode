//
//  PostListCell.swift
//  Typicode
//
//  Created by Lubarda, Miso on 04.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class PostListCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }

    func setup(withTitle title: String, body: String) {
        self.titleLabel.text = title
        self.bodyLabel.text = body
    }
}
