//
//  LinkViewTableViewCellTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class LinkViewTableViewCellTest: XCTestCase  {
    var viewModel: LinkCellViewModel!
    var link: Link!
    var sut: LinkTableViewCell!

    override func setUp() {
        super.setUp()
        var linkData: [String: Any] = LinkDataMock.linkData
        linkData["created_utc"] = 1_505_958_257
        linkData[Link.CodingKeys.title.rawValue] = "[Gamersgate] Tekken 7 ($26.49/%47 OFF), Tekken 7 Deluxe Edition ($43.04/%43 OFF) New Historical Low on Tekken 7"
        linkData[Link.CodingKeys.subredditNamePrefixed.rawValue] = "r/GameDeals"
        linkData[Link.CodingKeys.author.rawValue] = "BigBossTheSnake"
        linkData[Link.CodingKeys.domain.rawValue] = "loadingartist.com"
        
        link = DictionaryHelper.model(for: LinkDataMock.linkData)

        viewModel = LinkCellViewModel(link: link)
        
        sut = LinkTableViewCell()
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
    
    func testConfigureCell() {
        guard let link: Link = DictionaryHelper.model(for: LinkDataMock.linkData) else {
            XCTFail("Cannot load link")
            return
        }
        
        let viewModel = LinkCellViewModel(link: link)
        
        sut.viewModel = viewModel
        sut.configure()
        
        guard let expectedIntervalString = Date.timeIntervalString(
            fromDate: Date(timeInterval: link.createdUTC),
            toDate: Date()
            ) else {
                XCTFail("No interval string found.")
                return
        }
        
        XCTAssertEqual(sut.linkView.metaLabel.text, "\(link.subredditNamePrefixed) • \(expectedIntervalString) • \(link.domain.replacingOccurrences(of: ".com", with: ""))")
        XCTAssertEqual(sut.linkView.titleLabel.text, link.title)
    }
    
    func testCellLinkContent() {
        let cell = ImageLinkTableViewCell()
        
        XCTAssertTrue(type(of: cell.linkView.contentView) == type(of: UIImageView()))
    }
}
