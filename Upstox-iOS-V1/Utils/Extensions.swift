//
//  Extensions.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 25/07/25.
//

import UIKit

extension Double {
    func asCurrency(with symbol: String = "₹") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_IN") 
        return formatter.string(from: NSNumber(value: self)) ?? "\(symbol)0.00"
    }
}

extension UILabel {
    func setStyledText(_ text: String, color: UIColor? = nil) {
        self.text = text
        if let color = color {
            self.textColor = color
        }
    }
}

extension SummaryView {
    static func forCurrency(title: String, amount: Double) -> SummaryView {
        let view = SummaryView(title: title)
        let color: UIColor = amount < 0 ? .systemRed : .systemGreen
        let formatted = amount.asCurrency()
        view.update(value: formatted, color: color)
        return view
    }
}
