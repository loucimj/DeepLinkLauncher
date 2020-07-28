//
//  LauncherViewModel.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation

protocol LauncherPresenterDelegate {
    func linkIsInvalid(link: String)
    func didSaveLink(link: String)
    func didLaunchLink(link: String)
    func edit(link: String)
}

extension LauncherPresenterDelegate {
    func edit(link: String) {}
}

class LauncherPresenter {
    let delegate: LauncherPresenterDelegate
    let service: StorageManager
    init(delegate: LauncherPresenterDelegate, service: StorageManager = StorageService()) {
        self.delegate = delegate
        self.service = service
        startEditListener()
    }
    func save(link: String) {
        guard let url = URL(string: link) else {
            delegate.linkIsInvalid(link: link)
            return
        }
        service.add(url: url)
        delegate.didSaveLink(link: link)
    }
    func launch(link: String) {
        guard let url = URL(string: link) else {
            delegate.linkIsInvalid(link: link)
            return
        }
        do {
            let launcher = Launcher()
            try launcher.launch(url: url)
            delegate.didLaunchLink(link: link)
        } catch {
            delegate.linkIsInvalid(link: link)
        }
    }
    private func startEditListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(editEvent), name: .editLink, object: nil)
    }
    @objc func editEvent(_ notification: Notification) {
        guard let info = notification.userInfo as? [String: Any], let link = info["link"] as? String  else {
            return
        }
        delegate.edit(link: link)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
