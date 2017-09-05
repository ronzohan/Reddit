//
//  ListingTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/15/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit
import ObjectMapper

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
		
		let thingId = "8xwlg"
		let thingName = "t1_c3v7f8u"
		let thingKind = "t3"
		let thingData = [
			"author": "Ron",
			"id": thingId,
			"name": thingName,
		]
		
		let jsonThing: [String: Any] = [
			"kind": thingKind,
			"data": thingData
		]
		
		let jsonListingData: [String: Any] = [
			"before": listingBefore,
			"after": listingAfter,
			"modhash": listingModHash,
			"children": [jsonThing]
		]
		
		let jsonListing: [String: Any] = [
			"kind": "Listing",
			"data": jsonListingData
		]
		
		// When I parse that json
		
		listing = Listing(JSON: jsonListing)
		
		// Then thing mapper thing should have the same value on the json
		XCTAssertEqual(listing.after, listingAfter)
		XCTAssertEqual(listing.before, listingBefore)
		XCTAssertEqual(listing.modHash, listingModHash)
		XCTAssertEqual(listing.children.count, 1)
		
		XCTAssertEqual(listing.children[0].id, thingId)
		XCTAssertEqual(listing.children[0].name, thingName)
		XCTAssertEqual(listing.children[0].kind, Kind(rawValue: thingKind))
	}
	
	func testJSONListingWithNoData() {
		// Given I have a json
		let jsonListing: [String: Any] = [
			"kind": "Listing",
		]
		
		// When I parse that json
		listing = Listing(JSON: jsonListing)
		
		// Then thing mapper thing should have the same value on the json
		XCTAssertEqual(listing.after, nil)
		XCTAssertEqual(listing.before, nil)
		XCTAssertEqual(listing.modHash, "")
		XCTAssertEqual(listing.children.count, 0)
	}
}
