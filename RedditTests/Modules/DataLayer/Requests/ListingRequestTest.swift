//
//  RequestTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 12/1/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class ListingRequestTest: XCTestCase {    
    func testListingRequest() {
        // Given
        let subreddit = "all"
        let config = EndpointConfig(host: "www.reddit.com")
        
        // When
        
        let request = ListingEndpoint(with: config, 
                                     subreddit: subreddit)

        // Then
        XCTAssertEqual(request.fullPath, "www.reddit.com/r/all")
        XCTAssertEqual(request.method, .get)
    }
}
