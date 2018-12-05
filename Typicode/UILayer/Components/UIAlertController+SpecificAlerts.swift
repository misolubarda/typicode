//
//  UIAlertController+SpecificAlerts.swift
//  Typicode
//
//  Created by Lubarda, Miso on 05.12.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func fetchDataErrorAlert(_ reloadHandler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alertVC = UIAlertController(title: "Something went wrong", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel))
        alertVC.addAction(UIAlertAction(title: "Reload", style: .default, handler: reloadHandler))
        return alertVC
    }
}
