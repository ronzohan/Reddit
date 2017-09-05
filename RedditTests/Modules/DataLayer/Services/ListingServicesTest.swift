//
//  ListingServicesTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/15/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class ListingServicesTest: XCTestCase {
	
	var listingService: ListingServices!
	
    override func setUp() {
        super.setUp()

		listingService = ListingServices()
    }
	
	func testFetchListingFromApi() {
		// Given I have a subreddit
		let subreddit = "Dota2"
		
		// When I fetch the subreddit links
		//let links = listingService.fetchSubredditListing(subreddit: subreddit)
		
		// Then the links should have fetched t he links
		// TODO:
	}
}
