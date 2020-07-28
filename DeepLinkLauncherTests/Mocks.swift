//
//  Mocks.swift
//  DeepLinkLauncherTests
//
//  Created by Javier Loucim on 28/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation

struct Mocks {
    static var testURL: URL = URL(string: "http://google.com")!
    static var testURL2: URL = URL(string: "http://apple.com")!
    static var validLink: String = "http://google.com"
    static var invalidLink: String = "http://    google.com"
}
