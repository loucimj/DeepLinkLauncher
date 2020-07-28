//
//  StorageManagerTests.swift
//  DeepLinkLauncherTests
//
//  Created by Javier Loucim on 24/07/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Quick
import Nimble

@testable import DeepLinkLauncher

class StorageServiceTests: QuickSpec {
    var testURL: URL = URL(string: "http://google.com")!
    var testURL2: URL = URL(string: "http://apple.com")!
    
    override func spec() {
        context("storage") {
            it("stores data properly") {
                let service = StorageService()
                service.removeAll()
                service.add(url: self.testURL)
                let urls = service.getURLs()
                expect(urls.first).to(equal(self.testURL))
            }
            it("removes a link") {
                let service = StorageService()
                service.removeAll()
                service.add(url: self.testURL)
                let urls = service.getURLs()
                expect(urls.first).to(equal(self.testURL))
                
                service.remove(url: self.testURL)
                let newUrls = service.getURLs()
                expect(newUrls.first).to(beNil())
            }
            it("retrives saved data between sessions") {
                let service = StorageService()
                service.removeAll()
                service.add(url: self.testURL)

                let newService = StorageService()
                let urls = newService.getURLs()
                expect(urls.first).to(equal(self.testURL))
            }
            it("saves data properly from different threads") {
                let group = DispatchGroup()
                let service = StorageService()
                service.removeAll()

                let newService = StorageService()

                group.enter()
                group.enter()
                
                DispatchQueue.global(qos: .background).async {
                    newService.add(url: self.testURL2)
                    group.leave()
                }
                DispatchQueue.global(qos: .userInitiated).async {
                    service.add(url: self.testURL)
                    group.leave()
                }
                
                waitUntil { done in
                    group.notify(queue: .main) {
                        let urls = newService.getURLs()
                        expect(urls.count).to(equal(2))
                        done()
                    }
                    group.wait()
                }
                
            }
        }
    }
}
