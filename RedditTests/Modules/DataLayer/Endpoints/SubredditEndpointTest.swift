//
//  SubredditEndpointTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 12/8/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class SubredditEndpointTest: XCTestCase {
    let subreddit = "all"
    
    func testSubredditHotEndpoint() {
        // Given
        // When
        let endpoint = SubredditEndpoint.hot(subreddit: subreddit)

        // Then
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.path, "/r/\(subreddit)/hot")
    }
    
    func testSubredditNewEndpoint() {
        // Given
        // When
        let endpoint = SubredditEndpoint.new(subreddit: subreddit)
        
        // Then
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.path, "/r/\(subreddit)/new")
    }
    
    func testSubredditRisingEndpoint() {
        // Given
        // When
        let endpoint = SubredditEndpoint.rising(subreddit: subreddit)
        
        // Then
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.path, "/r/\(subreddit)/rising")
    }
}
