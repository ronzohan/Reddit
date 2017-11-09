//
//  LinkViewTableViewCellTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class LinkViewTableViewCellTest: XCTestCase {
    var viewModel: LinkCellViewModel!
    var link: Link!

    override func setUp() {
        super.setUp()
        link = Link()
        link.createdUTC = 1_505_958_257
        link.title = "[Gamersgate] Tekken 7 ($26.49/%47 OFF), Tekken 7 Deluxe Edition ($43.04/%43 OFF) New Historical Low on Tekken 7"
        link.subredditNamePrefixed = "r/GameDeals"
        link.author = "BigBossTheSnake"
        link.domain = "loadingartist.com"

        viewModel = LinkCellViewModel(link: link)
    }

    func testViewModelMeta() {
        let cleanDomain = link.domain.replacingOccurrences(of: ".com", with: "")

        guard let date = Date.timeIntervalString(fromDate: Date(timeInterval: link.createdUTC), toDate: Date()) else {
            XCTFail("No Date Found.")
            return
        }

        let expectedMeta = "\(link.subredditNamePrefixed) • \(date) • \(cleanDomain)"
        XCTAssertEqual(viewModel.meta, expectedMeta)
    }
}
