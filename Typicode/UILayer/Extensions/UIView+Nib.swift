//
//  UIView+Nib.swift
//  Typicode
//
//  Created by Lubarda, Miso on 04.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib() {
        guard let className = NSStringFromClass(type(of: self)).split(separator: ".").last else { return }
        let nib = UINib(nibName: String(className), bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)

        guard let view = views.first as? UIView else {
            return
        }

        fill(with: view)
    }
}
