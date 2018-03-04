//
//  UrlLinkViewTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 3/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class UrlLinkViewTest: XCTestCase {
    func testUrlLinkViewSetCaption() {
        // Given
        let caption = "www.google.com"
        let urlLinkView = UrlLinkView()
        
        // When
        urlLinkView.setCaption(caption)
        
        // Then
        XCTAssertEqual(urlLinkView.imageView.caption, caption)
    }
}
