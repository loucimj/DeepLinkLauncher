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
}

class StorageManager {
    
}
