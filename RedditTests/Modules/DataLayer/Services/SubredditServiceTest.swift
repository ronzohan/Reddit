//
//  SubredditServiceTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 12/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class SubredditServiceTest: XCTestCase {
    var config = RequestConfig(host: "www.reddit.com")
    var adapter = NetworkAdapterMock()
    var sut: SubredditService?
    
    let subreddit = "all"
    
    override func setUp() {
        super.setUp()
        
        sut = SubredditService(adapter: adapter, config: config)
    }
    
    func testGetNewPosts() {
        // Given
        // When
        sut?.newPosts(forSubreddit: subreddit)
            .subscribe()
            .dispose()
        
        // Then
        XCTAssertEqual(adapter.request?.endpoint.path, 
                       SubredditEndpoint.new(subreddit: subreddit).path)
    }
    
    func testGetNewPostsWithBodyParams() {
        // Given
        let bodyParams: [String: Any] = [
            "count": 1,
            "before": "asdnjk22",
            "raw_json": 1
        ]
        
        // When
        sut?.newPosts(forSubreddit: subreddit, bodyParams: bodyParams)
            .subscribe()
            .dispose()
        
        // Then
        XCTAssertEqual(adapter.request?.endpoint.path, 
                       SubredditEndpoint.new(subreddit: subreddit).path)

        guard let request = adapter.request else {
            XCTFail("No request found.")
            return
        }
        
        XCTAssertEqual(NSDictionary(dictionary: request.bodyParams), 
                       NSDictionary(dictionary: bodyParams))
    }
    
    func testGetHotPosts() {
        // Given
        // When
        sut?.hotPosts(forSubreddit: subreddit)
            .subscribe()
            .dispose()

        // Then
        XCTAssertEqual(adapter.request?.fullPath,
                       "\(config.host)\(SubredditEndpoint.hot(subreddit: subreddit).path).json")
    }
    
    func testGetHotPostsWithBodyParams() {
        // Given
        let bodyParams: [String: Any] = [
            "count": 1,
            "before": "asdnjk22",
            "raw_json": 1
        ]
        
        // When
        sut?.hotPosts(forSubreddit: subreddit, bodyParams: bodyParams)
            .subscribe()
            .dispose()
        
        // Then
        XCTAssertEqual(adapter.request?.endpoint.path, 
                       SubredditEndpoint.hot(subreddit: subreddit).path)
        
        guard let request = adapter.request else {
            XCTFail("No request found.")
            return
        }
        
        XCTAssertEqual(NSDictionary(dictionary: request.bodyParams), 
                       NSDictionary(dictionary: bodyParams))
    }
}
