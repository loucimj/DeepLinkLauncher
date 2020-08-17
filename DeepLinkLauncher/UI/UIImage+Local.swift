//
//  UIImage+Local.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 15/08/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static var link: UIImage {
         UIImage(systemName: "link", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)) ?? UIImage()
    }
    static var history: UIImage {
         UIImage(systemName: "list.dash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)) ?? UIImage()
    }
    static var success: UIImage {
         UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)) ?? UIImage()
    }
    static var error: UIImage {
         UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)) ?? UIImage()
    }
    static var delete: UIImage {
         UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .medium)) ?? UIImage()
    }
}
