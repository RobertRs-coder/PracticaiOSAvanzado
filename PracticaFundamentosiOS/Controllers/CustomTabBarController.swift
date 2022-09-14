//
//  CustomTabBarController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 14/9/22.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Tab Bar Customisation
//        tabBar.barTintColor = .systemPink
//        tabBar.tintColor = .systemTeal
//        tabBar.unselectedItemTintColor = .systemGray
//        tabBar.isTranslucent = true

        viewControllers = [
            createTabBarController(tabBarTitle: "Heroes", tabBarImage: "pencil", viewController: HeroesTableViewController()),
            createTabBarController(tabBarTitle: "Settings", tabBarImage: "circle.hexagongrid.fill", viewController: SettingsViewController())
        ]
    }

    func createTabBarController(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.tabBarItem.image = UIImage(systemName: tabBarImage)

        // Nav Bar Customisation
//        navigationController.navigationBar.barTintColor = .systemRed
//        navigationController.navigationBar.tintColor = .systemBlue
//        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }
}
