//
//  UIViewController+Extensions.swift
//  Upstox-iOS-V1
//
//  Created by Ashis Kumar Mishra on 25/07/25.
//

import UIKit

extension UIViewController {
    func showErrorAlert(title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
