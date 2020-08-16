//
//  UIFont+Local.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 13/08/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static var button: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    static var placeholder: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    static var textField: UIFont {
        return placeholder
    }
    static var cellTitle: UIFont {
        return placeholder
    }
}
