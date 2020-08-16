//
//  StorageManager.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation

fileprivate class StorageManagerData {
    static var shared = StorageManagerData()
    
    lazy var queue: DispatchQueue = {
        let queue = DispatchQueue(label: "storageQueue")
        return queue
    }()
    private lazy var dataMangementuQeue: DispatchQueue = {
        let queue = DispatchQueue(label: "dataManagementQueue")
        return queue
    }()
    private var urls: [URL] = []
    private let storageKey = "urls"
    init() {
        readSavedURLs()
    }
    func insert(url: URL) {
        guard !urls.contains(url) else { return }
        queue.sync {
            urls.insert(url, at: 0)
            saveURLs()
        }
    }
    func getURLs() -> Array<URL> {
        queue.sync {
            return Array(urls)
        }
    }
    func remove(url: URL) {
        queue.sync {
            urls = urls.filter({ $0 != url})
        }
    }
    private func saveURLs() {
        dataMangementuQeue.sync {
            let values = urls.map( { $0.absoluteString })
            UserDefaults.standard.setValue(values, forKey: storageKey)
        }
    }
    private func readSavedURLs() {
        dataMangementuQeue.sync {
            guard let storedURLs = UserDefaults.standard.array(forKey: storageKey) as? Array<String> else { return }
            urls = storedURLs.map({ URL(string: $0)! })
        }
    }
    func resetStorage() {
        urls = []
    }
}

protocol StorageManager {
    func add(url: URL)
    func getURLs() -> Array<URL>
    func remove(url: URL)
    func removeAll()
}

class StorageService: StorageManager {
    public func add(url: URL) {
        StorageManagerData.shared.insert(url: url)
    }
    func getURLs() -> Array<URL> {
        return StorageManagerData.shared.getURLs()
    }
    func remove(url: URL) {
        StorageManagerData.shared.remove(url: url)
    }
    func removeAll() {
        StorageManagerData.shared.resetStorage()
    }

}
