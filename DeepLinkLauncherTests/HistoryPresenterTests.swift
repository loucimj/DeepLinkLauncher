//
//  HistoryViewModelTests.swift
//  DeepLinkLauncherTests
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Quick
import Nimble

@testable import DeepLinkLauncher

fileprivate class MockHistoryPresenterDelegate: HistoryPresenterDelegate {
    func didRemove(url: URL) {}
    
    func didRemoveAllLinks() {}
    
    
    var urls: [URL] = []
    var launchedURL: URL?
    var hasError: Bool = false
    
    func didReceiveUrls(urls: [URL]) {
        self.urls = urls
    }
    
    func didLaunchLink(url: URL) {
        self.launchedURL = url
    }
    
    func didHaveAnErrorLaunching(url: URL) {
        hasError = true
    }
    
    
}

fileprivate class MockLauncherPresenterDelegate: LauncherPresenterDelegate {
    func linkIsInvalid(link: String) {}
    
    func didSaveLink(link: String) {}
    
    func didLaunchLink(link: String) {}
    
    var linkForEditing: String?
    func edit(link: String) {
        linkForEditing = link
    }
}

class HistoryPresenterTests: QuickSpec {
    
    override func spec() {
        beforeSuite {
            let service = StorageService()
            service.removeAll()
        }
        it("reads all links stored") {
            let delegate = MockHistoryPresenterDelegate()
            let service = StorageService()
            service.add(url: Mocks.testURL)
            service.add(url: Mocks.testURL2)
            _ = HistoryPresenter(delegate: delegate)
            expect(delegate.urls.count).to(equal(2))
        }
        it("triggers a notification when a new link has been added") {
            let delegate = MockHistoryPresenterDelegate()
            let otherService = StorageService()
            
            otherService.removeAll()
            otherService.add(url: Mocks.testURL)
            
            let presenter = HistoryPresenter(delegate: delegate)
            
            expect(delegate.urls.count).to(equal(1))
            
            otherService.add(url: Mocks.testURL2)
            
            presenter.readURLs()
            expect(delegate.urls.count).to(equal(2))

            
        }
        it("launches a link on demand") {
            let delegate = MockHistoryPresenterDelegate()
            let presenter = HistoryPresenter(delegate: delegate)

            presenter.launch(url: Mocks.testURL)
            expect(delegate.launchedURL).to(equal(Mocks.testURL))
        }
        it("allows the user to select a link for editing") {
            let delegate = MockHistoryPresenterDelegate()
            let presenter = HistoryPresenter(delegate: delegate)
            
            let launcherDelegate = MockLauncherPresenterDelegate()
            let launcherPresenter = LauncherPresenter(delegate: launcherDelegate)
            expect(launcherPresenter).notTo(beNil())
            presenter.edit(url: Mocks.testURL)
            
            expect(launcherDelegate.linkForEditing).to(equal(Mocks.testURL.absoluteString))
        }
        it("allows remove a link") {
            let service = StorageService()
            service.removeAll()
            let delegate = MockHistoryPresenterDelegate()
            let presenter = HistoryPresenter(delegate: delegate, service: service)
            
            service.add(url: Mocks.testURL)
            service.add(url: Mocks.testURL2)
            presenter.readURLs()
            
            expect(delegate.urls.count).to(equal(2))
            
            presenter.remove(url: Mocks.testURL)
            presenter.readURLs()
            
            expect(delegate.urls.count).to(equal(1))

        }
        it("allows to remove all links") {
            let service = StorageService()
            service.removeAll()
            let delegate = MockHistoryPresenterDelegate()
            let presenter = HistoryPresenter(delegate: delegate, service: service)
            
            service.add(url: Mocks.testURL)
            service.add(url: Mocks.testURL2)
            presenter.readURLs()
            
            expect(delegate.urls.count).to(equal(2))
            
            presenter.removeAll()
            presenter.readURLs()
            
            expect(delegate.urls.count).to(equal(0))
        }
        afterSuite {
            let service = StorageService()
            service.removeAll()
        }
    }
}
