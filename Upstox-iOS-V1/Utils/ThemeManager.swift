//
//  ThemeManager.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 24/07/25.
//

import UIKit

struct ThemeManager {

    // MARK: - Apply Global Appearance
    static func applyGlobalAppearance() {
        configureNavigationBarAppearance()
        configureTabBarAppearance()
        configureFontAppearance()
        configureTableViewAppearance()
    }

    // MARK: - Constants
    private enum Constants {
        static let navigationBackgroundColor = UIColor(red: 2/255, green: 53/255, blue: 109/255, alpha: 1)
        static let tabBarBackgroundColor = UIColor(hex: "#E6E5E6")
        static let tabBarSelectedColor = UIColor(hex: "#1E4EBC")
        static let tabBarUnselectedColor = UIColor(hex: "#959695")
        static let tabBarTintColor = UIColor(hex: "#748CCC")
        static let tabBarUnselectedItemTintColor = UIColor(hex: "#D5D6D5")
        static let fontFamily = "HelveticaNeue"
    }

    // MARK: - UINavigationBar Appearance
    private static func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.navigationBackgroundColor

        let titleFont = UIFont(name: Constants.fontFamily, size: 18) ?? .systemFont(ofSize: 18, weight: .semibold)
        let largeTitleFont = UIFont(name: Constants.fontFamily, size: 32) ?? .systemFont(ofSize: 32, weight: .bold)

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: titleFont
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: largeTitleFont
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white

        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: titleFont,
            .foregroundColor: UIColor.white
        ], for: .normal)
    }

    // MARK: - UITabBar Appearance
    private static func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.tabBarBackgroundColor

        let selectedFont = UIFont(name: Constants.fontFamily, size: 12) ?? .systemFont(ofSize: 12)
        let normalFont = UIFont(name: Constants.fontFamily, size: 12) ?? .systemFont(ofSize: 12)

        appearance.stackedLayoutAppearance.selected.iconColor = Constants.tabBarSelectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: Constants.tabBarSelectedColor,
            .font: selectedFont
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = Constants.tabBarUnselectedColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: Constants.tabBarUnselectedColor,
            .font: normalFont
        ]

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }

        UITabBar.appearance().tintColor = Constants.tabBarTintColor
        UITabBar.appearance().unselectedItemTintColor = Constants.tabBarUnselectedItemTintColor
    }

    // MARK: - Global Font Appearance
    private static func configureFontAppearance() {
        let fontName = Constants.fontFamily
        UILabel.appearance().substituteFontName = fontName
        UIButton.appearance().substituteFontName = fontName
        UITextView.appearance().substituteFontName = fontName
        UITextField.appearance().substituteFontName = fontName
    }

    // MARK: - UITableView Appearance
    private static func configureTableViewAppearance() {
        UITableView.appearance().backgroundColor = .systemBackground
        UITableViewCell.appearance().backgroundColor = .clear
    }
}
