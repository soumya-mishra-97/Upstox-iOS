//
//  PortfolioBottomSheetView.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 25/07/25.
//

import UIKit

class PortfolioBottomSheetView: UIView {
    
    private var isExpanded = false
    var heightChanged: ((CGFloat) -> Void)?
    private var dividerView: UIView?
    private var heightConstraint: NSLayoutConstraint?
    
    private let arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let profitLossLabel: UILabel = {
        let label = UILabel()
        label.text = "Profit & Loss*"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let profitLossValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    private let currentValueLabel = SummaryView(title: "Current value*")
    private let investmentLabel = SummaryView(title: "Total investment*")
    private let todaysPLLabel = SummaryView(title: "Today's Profit & Loss*")
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.isHidden = true
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = UIColor(hex: "#F4F5F5")
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor.lightGray
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.isHidden = true
        
        let labelArrowStack = UIStackView(arrangedSubviews: [profitLossLabel, arrowButton])
        labelArrowStack.axis = .horizontal
        labelArrowStack.spacing = 4
        labelArrowStack.alignment = .center
        
        let bottomRowStack = UIStackView(arrangedSubviews: [labelArrowStack, profitLossValueLabel])
        bottomRowStack.axis = .horizontal
        bottomRowStack.alignment = .center
        bottomRowStack.distribution = .equalSpacing
        
        let containerStack = UIStackView(arrangedSubviews: [stackView, dividerView, bottomRowStack])
        containerStack.axis = .vertical
        containerStack.spacing = 12
        
        addSubview(containerStack)
        
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            arrowButton.widthAnchor.constraint(equalToConstant: 16),
            arrowButton.heightAnchor.constraint(equalToConstant: 10),
            
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        stackView.addArrangedSubview(currentValueLabel)
        stackView.addArrangedSubview(investmentLabel)
        stackView.addArrangedSubview(todaysPLLabel)
        
        arrowButton.addTarget(self, action: #selector(toggleExpandCollapse), for: .touchUpInside)
        
        self.dividerView = dividerView // store reference for toggle
    }
    
    // MARK: - Configuration
    func configure(currentValue: Double, investment: Double, todaysPL: Double) {
        let overallPL = currentValue - investment
        let percent = investment != 0 ? (overallPL / investment) * 100 : 0
        
        profitLossValueLabel.text = "\(overallPL.asCurrency()) (\(String(format: "%.2f", percent))%)"
        profitLossValueLabel.textColor = overallPL < 0 ? .systemRed : .systemGreen
        
        currentValueLabel.update(value: currentValue.asCurrency())
        investmentLabel.update(value: investment.asCurrency())
        
        let prefix = todaysPL >= 0 ? "" : "-"
        todaysPLLabel.update(
            value: "\(prefix)\(abs(todaysPL).asCurrency())",
            color: todaysPL >= 0 ? .systemGreen : .systemRed
        )
    }
    
    // MARK: - Expand / Collapse BottomSheet
    @objc private func toggleExpandCollapse() {
        isExpanded.toggle()
        
        stackView.isHidden = !isExpanded
        dividerView?.isHidden = !isExpanded
        
        let icon = isExpanded ? "chevron.down" : "chevron.up"
        arrowButton.setImage(UIImage(systemName: icon), for: .normal)
        
        let newHeight: CGFloat = isExpanded ? 160 : 50
        heightChanged?(newHeight)
    }
}
