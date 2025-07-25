//
//  PositionViewController.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 24/07/25.
//

import UIKit

class PositionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    private func setupNavigationBar() {
        self.view.backgroundColor = .white
        navigationItem.title = "Position"
        
        let titleLabel = UILabel()
        titleLabel.text = "Position View"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.sizeToFit()
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
