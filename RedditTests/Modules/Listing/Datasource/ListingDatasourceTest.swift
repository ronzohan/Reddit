//
//  ListingDatasourceTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 10/3/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class ListingDatasourceTest: XCTestCase {
	func testDatasourceInit() {
		let link1 = Link()
		link1.title = "A 19 year old Sofia Vergara"
		link1.subredditNamePrefixed = "r/pics"
		link1.createdUTC = 1506946298
		link1.domain = "i.imgur.com"
		
		let listing = Listing()
		listing.children = [link1]
		let _ = ListingDatasource(listing: listing)
	}
	
	func testDatasourceNumberOfSections() {
		
	}
}
