//
//  UIView+Subview.swift
//  Typicode
//
//  Created by Lubarda, Miso on 04.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

extension UIView {
    func fill(with subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)

        leftAnchor.constraint(equalTo: subview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: subview.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
    }
}
