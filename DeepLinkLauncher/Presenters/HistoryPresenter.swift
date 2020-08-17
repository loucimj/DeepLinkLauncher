//
//  HistoryViewModel.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation

protocol HistoryPresenterDelegate {
    func didReceiveUrls(urls: [URL])
    func didLaunchLink(url: URL)
    func didHaveAnErrorLaunching(url: URL)
    func didRemove(url: URL)
    func didRemoveAllLinks()
}

class HistoryPresenter {
    var delegate: HistoryPresenterDelegate
    var service: StorageManager
    
    init(delegate: HistoryPresenterDelegate, service: StorageManager = StorageService()) {
        self.delegate = delegate
        self.service = service
        
        dataInitialization()
    }
    private func dataInitialization() {
        let urls = service.getURLs()
        guard !urls.isEmpty else { return }
        delegate.didReceiveUrls(urls: urls)
    }
    func readURLs() {
        let urls = service.getURLs()
        delegate.didReceiveUrls(urls: urls)
    }
    func launch(url: URL) {
        do {
            let launcher = Launcher()
            try launcher.launch(url: url)
            delegate.didLaunchLink(url: url)
        } catch {
            delegate.didHaveAnErrorLaunching(url: url)
        }
    }
    func edit(url: URL) {
        NotificationCenter.default.post(name: .editLink, object: self, userInfo: ["link": url.absoluteString])
    }
    func remove(url: URL) {
        service.remove(url: url)
        delegate.didRemove(url: url)
    }
    func removeAll() {
        guard !service.getURLs().isEmpty else { return }
        service.removeAll()
        delegate.didRemoveAllLinks()
    }
    
}
