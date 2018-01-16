//
//  ListingTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/15/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class ListingTest: XCTestCase {

    var listing: Listing!

    override func setUp() {
        super.setUp()
    }

    func testJSONToListing() {
        // Given I have a json
        let listingBefore = "8xwlg"
        let listingAfter = "t1_c3v7f8u"
        let listingModHash = "t3"

        let thingKind = "t3"

        let jsonThing: [String: Any] = [
            "kind": thingKind,
            "data": LinkDataMock.linkData,
        ]

        let jsonListingData: [String: Any] = [
            "before": listingBefore,
            "after": listingAfter,
            "modhash": listingModHash,
            "children": [jsonThing, jsonThing],
        ]

        let jsonListing: [String: Any] = [
            "kind": "Listing",
            "data": jsonListingData
        ]

        // When I parse that json
        listing = DictionaryHelper.model(for: jsonListing)

        // Then thing mapper thing should have the same value on the json
        XCTAssertEqual(listing.after, listingAfter)
        XCTAssertEqual(listing.before, listingBefore)
        XCTAssertEqual(listing.modHash, listingModHash)
        XCTAssertEqual(listing.children.count, 2)
    }

    // Not supported
    func testJSONListingWithNoData() {
        // Given I have a json
        let jsonListing: [String: Any] = [
            "kind": "Listing",
            "data": [:]
        ]

        // When I parse that json
        listing = DictionaryHelper.model(for: jsonListing)

        // Then thing mapper thing should have the same value on the json
        XCTAssertEqual(listing.after, nil)
        XCTAssertEqual(listing.before, nil)
        XCTAssertEqual(listing.modHash, nil)
        XCTAssertEqual(listing.children.count, 0)
    }
}
