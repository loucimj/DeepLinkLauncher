//
//  Alertable.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 17/08/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import StatusAlert

protocol Alertable {
    func showAlertWithError(message: String, title: String)
    func showAlertWithSucccess(message: String, title: String)
    func showAlertWith(message: String, title: String, image: UIImage)
}

extension Alertable {
    func showAlertWithError(message: String, title: String = "") {
        show(message: message, title: title, image: UIImage.error)
    }
    func showAlertWithSucccess(message: String, title: String = "") {
        show(message: message, title: title, image: UIImage.checkmark)
    }
    func showAlertWith(message: String, title: String, image: UIImage) {
        show(message: message, title: title, image: image)
    }
    fileprivate func show(message: String, title: String, image: UIImage) {
        let statusAlert = StatusAlert()
        statusAlert.image = image
        statusAlert.title = title
        statusAlert.message = message
        statusAlert.canBePickedOrDismissed = true
        statusAlert.showInKeyWindow()
    }
}
