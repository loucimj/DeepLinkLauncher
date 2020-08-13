//
//  LinkLauncherViewController.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

class LinkLauncherViewController: UIViewController {
    
    private lazy var button: OutlinedButton = {
        return OutlinedButton(text: "Open") { [weak self] in
            guard let self = self else { return }
            self.open()
        }
    }()
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupViews()
    }
    // MARK: - Functions
    private func setupViews() {
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(button)
        button.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 24, bottom: 32, right: 24), excludingEdge: .top)
    }
    private func setupNavigationBar() {
        title = "Launcher"
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarItem = UITabBarItem(title: "Launcher", image: UIImage(systemName: "link.circle.fill"), selectedImage: nil)
    }
    // MARK: - Actions
    private func open() {
        
    }
}
