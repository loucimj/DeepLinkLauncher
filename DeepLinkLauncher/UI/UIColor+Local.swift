//
//  UIColor+Local.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 13/08/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var accent: UIColor {
        return UIColor(named: "AccentColor") ?? UIColor()
    }
    static var destructive: UIColor {
        return UIColor(named: "DestructiveColor") ?? UIColor()
    }
    static var tabbarBackground: UIColor {
        return UIColor(named: "TabBarBackgroundColor") ?? UIColor()
    }
    static var tabbarText: UIColor {
        return UIColor(named: "TabBarTextColor") ?? UIColor.white
    }
    static var placeholderText: UIColor {
        return UIColor(named: "PlaceholderTextColor") ?? UIColor.white
    }
    static var textFieldBackground: UIColor {
        return UIColor(named: "TextFieldBackgroundColor") ?? UIColor.white
    }
    static var textFieldTextColor: UIColor {
        return UIColor(named: "NormalTextColor") ?? UIColor.black
    }
}
