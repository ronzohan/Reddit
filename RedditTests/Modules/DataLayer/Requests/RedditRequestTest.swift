//
//  RequestTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 12/1/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class RedditRequestTest: XCTestCase {    
    func testRequest() {
        // Given
        let host = "www.reddit.com"
        let config = RequestConfig(host: host)
        
        // When
        let request = RedditRequest(config: config, endpoint: EndpointMock.getEndpoint)

        // Then
        XCTAssertEqual(request.fullPath, "\(host)\(EndpointMock.getEndpoint.path).json")
        
        XCTAssertEqual(request.bodyParams["raw_json"] as? Int, 1)
    }
}
