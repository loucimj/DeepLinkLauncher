//
//  HistoryViewController.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(forAutoLayout: ())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: ImageAndTextTableViewCell.self)
        return tableView
    }()
    private lazy var button: OutlinedButton = {
        return OutlinedButton(text: "Remove all", style: .destructive) { [weak self] in
            guard let self = self else { return }
            self.removeAll()
        }
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBarItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    private func setupTabBarItems() {
        tabBarItem = UITabBarItem(title: "History", image: UIImage.history, selectedImage: nil)
    }
    private func setupNavigationBar() {
        title = "History"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupViews() {
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(tableView)
        view.addSubview(button)
        button.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 24, bottom: 32, right: 24), excludingEdge: .top)
        tableView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets.zero, excludingEdge: .bottom)
        tableView.autoPinEdge(.bottom, to: .top, of: button, withOffset: -24)
    }
    
    private func removeAll() {
        
    }
}
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
