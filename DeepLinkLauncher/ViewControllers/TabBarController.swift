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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(didLaunchLink), name: .didLaunchLink, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editLink), name: .editLink, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Events
    @objc private func didLaunchLink() {
        selectedIndex = 1
    }
    @objc private func editLink() {
        selectedIndex = 0
    }
}

