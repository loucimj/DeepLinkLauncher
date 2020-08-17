//
//  HistoryViewController.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

extension URL: ImageAndTextTableViewCellRepresentable {
    var cellImage: UIImage {
        UIImage.link
    }
    
    var cellTitle: String {
        absoluteString
    }
    
    
}

class HistoryViewController: UIViewController, Alertable {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(forAutoLayout: ())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        tableView.register(cellType: ImageAndTextTableViewCell.self)
        return tableView
    }()
    private lazy var button: OutlinedButton = {
        return OutlinedButton(text: "Remove all", style: .destructive) { [weak self] in
            guard let self = self else { return }
            self.removeAll()
        }
    }()
    private var launcherPresenter: LauncherPresenter?
    private var historyPresenter: HistoryPresenter?
    
    private var urls: [URL] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        launcherPresenter = LauncherPresenter(delegate: self)
        historyPresenter = HistoryPresenter(delegate: self)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    private func setupTabBarItem() {
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
        tableView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0), excludingEdge: .bottom)
        tableView.autoPinEdge(.bottom, to: .top, of: button, withOffset: -24)
    }
    private func getData() {
        historyPresenter?.readURLs()
    }
    private func removeAll() {
        historyPresenter?.removeAll()
        getData()
    }
}
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as ImageAndTextTableViewCell
        let url = urls[indexPath.row]
        cell.configure(with: url)
        cell.cellImageView.tintColor = UIColor.placeholderText
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = urls[indexPath.row]
        launcherPresenter?.launch(link: url.absoluteString)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}
extension HistoryViewController: HistoryPresenterDelegate {
    func didRemove(url: URL) {
        showAlertWithSucccess(message: "Deleted " + url.absoluteString)
    }
    
    func didRemoveAllLinks() {
        showAlertWithSucccess(message: "Deleted all links")
    }
    
    func didReceiveUrls(urls: [URL]) {
        self.urls = urls
        tableView.reloadData()
    }
    
    func didLaunchLink(url: URL) {
        
    }
    
    func didHaveAnErrorLaunching(url: URL) {
        
    }
    
    
}
extension HistoryViewController: LauncherPresenterDelegate {
    func linkIsInvalid(link: String) {
        
    }
    
    func didSaveLink(link: String) {
        getData()
    }
    
    func didLaunchLink(link: String) {
    }
    
    
}
