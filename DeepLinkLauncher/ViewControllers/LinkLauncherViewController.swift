//
//  LinkLauncherViewController.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

class LinkLauncherViewController: UIViewController, Alertable {
    
    private lazy var button: OutlinedButton = {
        return OutlinedButton(text: "Open") { [weak self] in
            guard let self = self else { return }
            self.open()
        }
    }()
    private lazy var textField: GrowingTextField = {
        return GrowingTextField(image: UIImage.link, placeholderText: "Type your link here", defaultText: "")
    }()
    
    private var launcherPresenter: LauncherPresenter?
        
    override func viewDidLoad() {
        setupNavigationBar()
        setupViews()
        launcherPresenter = LauncherPresenter(delegate: self)
    }
    // MARK: - Functions
    private func setupViews() {
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(button)
        view.addSubview(textField)
        button.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 24, bottom: 32, right: 24), excludingEdge: .top)
        textField.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 12, left: 24, bottom: 0, right: 24), excludingEdge: .bottom)
    }
    private func setupNavigationBar() {
        title = "Launcher"
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarItem = UITabBarItem(title: "Launcher", image: UIImage(systemName: "link.circle.fill"), selectedImage: nil)
    }
    // MARK: - Actions
    private func open() {
        guard let link = textField.text, !link.isEmpty else { return }
        launcherPresenter?.launch(link: link)
    }
}
extension LinkLauncherViewController: LauncherPresenterDelegate {
    func linkIsInvalid(link: String) {
        showAlertWithError(message: "Invalid link")
    }
    
    func didSaveLink(link: String) {
        
    }
    
    func didLaunchLink(link: String) {
        launcherPresenter?.save(link: link)
        showAlertWithSucccess(message: "Launched")
        NotificationCenter.default.post(name: .didLaunchLink, object: nil)
    }
    
    
}
