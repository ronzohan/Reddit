//
//  RequestConfig.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 12/4/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class RequestConfigTest: XCTestCase {    
    func testRequestConfig() {
        // Given
        let host = "www.reddit.com"
        
        // When
        let config = RequestConfig(host: host)
        
        // Then
        XCTAssertEqual(config.host, host)
    }
}
