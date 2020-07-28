//
//  LauncherTests.swift
//  DeepLinkLauncherTests
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Quick
import Nimble

@testable import DeepLinkLauncher

class LauncherTests: QuickSpec {

    override func spec() {
        it("launches a valid link") {
            let launcher = Launcher()
            do {
                try launcher.launch(url: URL(string: "http://www.google.com")!)
                expect(true).to(beTrue())
            } catch {
                fail()
            }
        }
        it("fails to open a invalid link") {
            let launcher = Launcher()
            do {
                try launcher.launch(url: URL(string: "whatsapp://something")!)
                fail()
            } catch {
                expect(true).to(beTrue())
            }
        }
        
    }
}
