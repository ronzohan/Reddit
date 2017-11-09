//
//  ListingEndpointTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/17/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class ListingEndpointTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testListingEndpointWithParams() {
        // Given I have parameters
        let parameters: [String: Any] = ["subreddit": "Dota2"]
        let expectedUrl = "https://www.reddit.com/r/Dota2/hot"

        // When I set the parameters of listing endpoint
        let listingEndpoint = ListingHotEndpoint()
        listingEndpoint.parameters = parameters

        // Then the new url should be the expected url
        XCTAssertEqual(listingEndpoint.url, expectedUrl)
    }

    func testListingEndpointWithAdditionalParameters() {
        // Given I have parameters
        let parameters: [String: Any] = ["subreddit": "Dota2", "limit": 14]
        let expectedUrl = "https://www.reddit.com/r/Dota2/hot?limit=14"

        // When I set the parameters of listing endpoint
        let listingEndpoint = ListingHotEndpoint()
        listingEndpoint.parameters = parameters

        // Then the new url should be the expected url
        XCTAssertEqual(listingEndpoint.url, expectedUrl)
    }
}
