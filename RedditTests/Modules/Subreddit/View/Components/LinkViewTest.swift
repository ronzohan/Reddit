//
//  TitleLinkViewTableViewCellTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class TitleLinkViewTableViewCellTest: XCTestCase  {
    var link: Link!
    var sut: TitleLinkTableViewCell!

    override func setUp() {
        super.setUp()
        var linkData: [String: Any] = LinkDataMock.linkData
        linkData["created_utc"] = 1_505_958_257
        linkData[Link.CodingKeys.title.rawValue] = "[Gamersgate] Tekken 7 ($26.49/%47 OFF), Tekken 7 Deluxe Edition ($43.04/%43 OFF) New Historical Low on Tekken 7"
        linkData[Link.CodingKeys.subredditNamePrefixed.rawValue] = "r/GameDeals"
        linkData[Link.CodingKeys.author.rawValue] = "BigBossTheSnake"
        linkData[Link.CodingKeys.domain.rawValue] = "loadingartist.com"
        
        link = DictionaryHelper.model(for: LinkDataMock.linkData)
        
        sut = TitleLinkTableViewCell()
    }
    
    func testConfigureCell() {
        // Given
        guard let link: Link = DictionaryHelper.model(for: LinkDataMock.linkData) else {
            XCTFail("Cannot load link")
            return
        }
        
        // When
        LinkViewPresenter.update(titleLinkView: sut.linkView, with: link)
        
        // Then
        let createdDate = Date(timeInterval: link.createdUTC)
        guard let expectedIntervalString = Date.timeIntervalString(fromDate: createdDate, 
                                                                   toDate: Date()) else {
                                                                    XCTFail("No interval string found.")
                                                                    return
        }
        
        XCTAssertEqual(sut.linkView.infoView.metaLabel.text, "\(link.subredditNamePrefixed) • \(expectedIntervalString) • \(link.domain.replacingOccurrences(of: ".com", with: ""))")
        XCTAssertEqual(sut.linkView.titleLabel.text, link.title)
    }
}
