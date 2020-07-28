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
            LinkLauncherViewController(),
            HistoryViewController()
        ]
    }()
    override func viewDidLoad() {
        setViewControllers(tabViewControllers, animated: true)
    }
}
