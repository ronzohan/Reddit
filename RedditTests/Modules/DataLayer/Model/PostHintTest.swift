//
//  PostHint.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 9/24/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class PostHintTest: XCTestCase {
    
    func testPostHintCreation() {
		let selfPostHint = Reddit.PostHint(rawValue: "self")
		XCTAssertEqual(selfPostHint, .redditSelf)
		
		let linkPostHint = Reddit.PostHint(rawValue: "link")
		XCTAssertEqual(linkPostHint, .link)
		
		let videoPostHint = Reddit.PostHint(rawValue: "video")
		XCTAssertEqual(videoPostHint, .video)
		
		let imagePostHint = Reddit.PostHint(rawValue: "image")
		XCTAssertEqual(imagePostHint, .image)
		
		let richVideoPostHint = Reddit.PostHint(rawValue: "rich:video")
		XCTAssertEqual(richVideoPostHint, .richVideo)
    }
}
