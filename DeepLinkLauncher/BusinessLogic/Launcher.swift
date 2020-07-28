//
//  Launcher.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

enum LauncherErrors: Error {
    case ApplicationNotAvailable
}

class Launcher {
    func launch(url: URL) throws {
        guard UIApplication.shared.canOpenURL(url) else {
            throw LauncherErrors.ApplicationNotAvailable
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
