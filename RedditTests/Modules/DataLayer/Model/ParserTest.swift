//
//  ParserTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class ParserTest: XCTestCase {
    func testParserWithNoData() {
        // Given I have a blank json Data
        let jsonData = [String: Any]()

        // When I parse the json Data using the thingFactory

        let thing = Parser.parseAny(json: jsonData)

        // Then thing should be nil
        XCTAssertNil(thing)
    }

    func testThingFactory() {
        // Given I have a link json data
        let thingId = "8xwlg"
        let thingName = "t1_c3v7f8u"

        let linkAuthor = "Ron"
        let linkTitle = "Witcher"
        let linkUrl = "www.google.com"

        let linkData = [
            "author": linkAuthor,
            "title": linkTitle,
            "url": linkUrl,
            "id": thingId,
            "name": thingName,
        ]

        // When I parse the thing data using a link kind
        let thing = ThingFactory.parseAny(Data: linkData, withKind: .link)

        // Then thing should be returns as a link
        XCTAssertTrue(thing is Link)

        guard let link = thing as? Link else {
            assertionFailure("Thing created was not a Link")
            return
        }

        XCTAssertEqual(link.id, thingId)
    }
}
