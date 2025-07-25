//
//  UIFont+Extension.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 25/07/25.
//

import UIKit

extension UILabel {
    @objc var substituteFontName: String {
        get { return self.font.fontName }
        set {
            if let size = self.font?.pointSize {
                self.font = UIFont(name: newValue, size: size)
            }
        }
    }
}

extension UIButton {
    @objc var substituteFontName: String {
        get { return self.titleLabel?.font.fontName ?? "" }
        set {
            guard let size = self.titleLabel?.font.pointSize else { return }
            self.titleLabel?.font = UIFont(name: newValue, size: size)
        }
    }
}

extension UITextView {
    @objc var substituteFontName: String {
        get { return self.font?.fontName ?? "" }
        set {
            if let size = self.font?.pointSize {
                self.font = UIFont(name: newValue, size: size)
            }
        }
    }
}

extension UITextField {
    @objc var substituteFontName: String {
        get { return self.font?.fontName ?? "" }
        set {
            if let size = self.font?.pointSize {
                self.font = UIFont(name: newValue, size: size)
            }
        }
    }
}
