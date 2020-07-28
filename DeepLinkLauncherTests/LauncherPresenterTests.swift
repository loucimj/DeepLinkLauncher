//
//  LauncherViewModelTests.swift
//  DeepLinkLauncherTests
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Quick
import Nimble

@testable import DeepLinkLauncher

class LaunchPresenterDelegate: LauncherPresenterDelegate {
    var isValid: Bool = false
    var didLaunchLink: Bool = false
    var wantsToEditLink: Bool = false
    func linkIsInvalid(link: String) {
        isValid = false
        didLaunchLink = false
    }
    
    func didSaveLink(link: String) {
        isValid = true
    }
    
    func didLaunchLink(link: String) {
        didLaunchLink = true
    }
    func edit(link: String) {
        wantsToEditLink = true
    }
    
}

class LauncherPresenterTests: QuickSpec {

    let delegate = LaunchPresenterDelegate()
    let service = StorageService()
        
    override func spec() {
        it("saves a valid link") {
            let presenter = LauncherPresenter(delegate: self.delegate, service: self.service)
            presenter.save(link: Mocks.validLink)
            expect(self.delegate.isValid).to(beTrue())
        }
        it("notifies when a link is invalid") {
            let presenter = LauncherPresenter(delegate: self.delegate, service: self.service)
            self.delegate.isValid = true
            presenter.save(link: Mocks.invalidLink)
            expect(self.delegate.isValid).to(beFalse())
        }
        it("launches a link on demand") {
            let presenter = LauncherPresenter(delegate: self.delegate, service: self.service)
            presenter.launch(link: Mocks.validLink)
            expect(self.delegate.didLaunchLink).to(beTrue())
        }
        it("fails to launch an invalid link") {
            let presenter = LauncherPresenter(delegate: self.delegate, service: self.service)
            self.delegate.didLaunchLink = true
            presenter.launch(link: Mocks.invalidLink)
            expect(self.delegate.didLaunchLink).to(beFalse())
        }
        it("allows to edit a valid link") {
            let presenter = LauncherPresenter(delegate: self.delegate, service: self.service)
            expect(presenter).notTo(beNil())
            self.delegate.wantsToEditLink = false
            let payload = ["link": Mocks.validLink]
            NotificationCenter.default.post(name: .editLink, object: nil, userInfo: payload)
            expect(self.delegate.wantsToEditLink).toEventually(beTrue())
        }
        it("fails to edit when event doesnt have link") {
            let presenter = LauncherPresenter(delegate: self.delegate, service: self.service)
            expect(presenter).notTo(beNil())
            self.delegate.wantsToEditLink = false
            let payload: [String: Any] = [:]
            NotificationCenter.default.post(name: .editLink, object: nil, userInfo: payload)
            expect(self.delegate.wantsToEditLink).toEventually(beFalse())
        }
    }

}
