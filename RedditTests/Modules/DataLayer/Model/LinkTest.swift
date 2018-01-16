//
//  LinkTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/15/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class LinkTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testJSONToLink() {
        // Given I have a json
        let linkData = LinkDataMock.linkData

        // When I parse that json
        let link: Link? = DictionaryHelper.model(for: linkData)

        // Then thing mapper thing should have the same value on the json
        XCTAssertEqual(link?.author, LinkDataMock.author)
        XCTAssertEqual(link?.title, LinkDataMock.title)
        XCTAssertEqual(link?.url, LinkDataMock.url)
    }

    func testInitForLink() {
        // Given I have a link
        let linkJSON: Link?

        // When I init the link to its blank init
        linkJSON = DictionaryHelper.model(for: [:])

        // Then it should have nil value
        XCTAssertNil(linkJSON)
    }
}
