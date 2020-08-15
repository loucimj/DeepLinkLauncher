//
//  TabController.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    lazy var tabViewControllers: [UIViewController] = {
        return [
            UINavigationController(rootViewController: LinkLauncherViewController()),
            UINavigationController(rootViewController: HistoryViewController())
        ]
    }()
    override func viewDidLoad() {
        setViewControllers(tabViewControllers, animated: true)
        tabBar.tintColor = UIColor.tabbarText
        tabBar.barTintColor = UIColor.tabbarBackground
        tabBar.isTranslucent = false
    }
}
