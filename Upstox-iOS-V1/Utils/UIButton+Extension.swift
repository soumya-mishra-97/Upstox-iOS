//
//  UIButton+Extension.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 25/07/25.
//

import UIKit

extension UIButton {
    static func systemIcon(_ name: String, size: CGFloat, tint: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: name), for: .normal)
        button.tintColor = tint
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: size).isActive = true
        button.heightAnchor.constraint(equalToConstant: size).isActive = true
        return button
    }
}
