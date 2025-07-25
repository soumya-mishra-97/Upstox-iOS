//
//  SegmentedControl.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 25/07/25.
//

import UIKit

extension UISegmentedControl {
    static func createStyled(
        items: [String],
        selectedIndex: Int = 0,
        target: Any?,
        action: Selector
    ) -> UnderlineSegmentedControl {
        let control = UnderlineSegmentedControl(items: items)
        control.selectedSegmentIndex = selectedIndex
        control.addTarget(target, action: action, for: .valueChanged)
        return control
    }
}

final class UnderlineSegmentedControl: UISegmentedControl {
    
    private var underlineView: UIView!
    private let underlineColor: UIColor = UIColor(hex: "#1E4EBC")
    private let underlineHeight: CGFloat = 1.0
    private let underlineBottomPadding: CGFloat = 6.0
    
    override init(items: [Any]?) {
        super.init(items: items)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        backgroundColor = .white
        selectedSegmentTintColor = .clear
        
        let font = UIFont(name: "HelveticaNeue-Medium", size: 14) ?? .systemFont(ofSize: 14, weight: .medium)
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#959695"),
            .font: font
        ]
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: font
        ]
        
        setTitleTextAttributes(normalAttributes, for: .normal)
        setTitleTextAttributes(selectedAttributes, for: .selected)
        
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        addTarget(self, action: #selector(updateUnderline), for: .valueChanged)
        
        underlineView = UIView()
        underlineView.backgroundColor = underlineColor
        addSubview(underlineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderline()
    }
    
    @objc private func updateUnderline() {
        guard let title = titleForSegment(at: selectedSegmentIndex),
              let font = titleTextAttributes(for: .selected)?[.font] as? UIFont else {
            return
        }
        
        let textWidth = (title as NSString).size(withAttributes: [.font: font]).width
        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        let xPosition = segmentWidth * CGFloat(selectedSegmentIndex) + (segmentWidth - textWidth) / 2
        
        UIView.animate(withDuration: 0.25) {
            self.underlineView.frame = CGRect(
                x: xPosition,
                y: self.bounds.height - self.underlineHeight - self.underlineBottomPadding,
                width: textWidth,
                height: self.underlineHeight
            )
        }
    }
}
