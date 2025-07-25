//
//  TabBarViewController.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 24/07/25.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let watchlistVC = createNavController(
            rootViewController: WatchlistViewController(),
            title: "Watchlist",
            systemImageName: "list.bullet"
        )
        
        let ordersVC = createNavController(
            rootViewController: OrdersViewController(),
            title: "Orders",
            systemImageName: "clock.arrow.circlepath"
        )
        
        let portfolioVC = createNavController(
            rootViewController: PortfolioViewController(),
            title: "Portfolio",
            systemImageName: "briefcase.fill"
        )
        
        let fundsVC = createNavController(
            rootViewController: FundsViewController(),
            title: "Funds",
            systemImageName: "indianrupeesign"
        )
        
        let investVC = createNavController(
            rootViewController: InvestsViewController(),
            title: "Invest",
            systemImageName: "wallet.bifold.fill"
        )
        
        viewControllers = [watchlistVC, ordersVC, portfolioVC, fundsVC, investVC]
    }
    
    private func createNavController(
        rootViewController: UIViewController,
        title: String,
        systemImageName: String
    ) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        let icon = UIImage(systemName: systemImageName, withConfiguration: imageConfig)
        nav.tabBarItem = UITabBarItem(title: title, image: icon, tag: 0)
        return nav
    }
}
