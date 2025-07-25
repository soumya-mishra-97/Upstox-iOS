//
//  PortfollioViewController.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 24/07/25.
//

import UIKit

final class PortfolioViewController: UIViewController {
    
    private let containerView = UIView()
    private let divider = UIView.divider()
    private let segmentTitles = ["POSITIONS", "HOLDINGS"]
    
    private lazy var positionVC = PositionViewController()
    private lazy var holdingVC = HoldingViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupLayout()
        displayCurrentVC(positionVC)
    }
    
    // MARK: - Setup
    private func setupNavigationBar() {

        let icon = UIImageView(image: UIImage(systemName: "person.crop.circle"))
        icon.tintColor = .white
        icon.setSize(width: 25, height: 25)
        
        let titleLabel = UILabel()
        titleLabel.text = "Portfolio"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        let titleStack = UIStackView(arrangedSubviews: [icon, titleLabel])
        titleStack.axis = .horizontal
        titleStack.spacing = 14
        titleStack.alignment = .center
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleStack)
        

        let sortButton = UIButton.systemIcon("arrow.up.arrow.down", size: 20, tint: .white)
        let searchButton = UIButton.systemIcon("magnifyingglass", size: 20, tint: .white)
        
        let divider = UIView.verticalDivider(height: 20, color: .white.withAlphaComponent(0.4))
        let dividerItem = UIBarButtonItem(customView: divider)
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 14

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: searchButton),
            fixedSpace,
            dividerItem,
            fixedSpace,
            UIBarButtonItem(customView: sortButton)
        ]
    }
    
    /// Sagement Control
    private lazy var segmentedControl: UISegmentedControl = {
        return UISegmentedControl.createStyled(
            items: segmentTitles,
            selectedIndex: 0,
            target: self,
            action: #selector(segmentChanged(_:))
        )
    }()

    /// Layout Setup
    private func setupLayout() {
        view.addSubviews(segmentedControl, divider, containerView)
        
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                height: 44)
        
        divider.anchor(top: segmentedControl.bottomAnchor,
                       leading: view.leadingAnchor,
                       trailing: view.trailingAnchor,
                       height: 1)
        
        containerView.anchor(top: divider.bottomAnchor,
                             leading: view.leadingAnchor,
                             bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    /// Segment Control Action
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            displayCurrentVC(positionVC)
        case 1:
            displayCurrentVC(holdingVC)
        default:
            break
        }
    }
    
    /// View Switching
    private func displayCurrentVC(_ vc: UIViewController) {
        children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.view.frame = containerView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
    }
}



