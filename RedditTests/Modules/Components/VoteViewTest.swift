//
//  VoteButton.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 1/24/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class VoteViewTest: XCTestCase {
    var voteView = VoteView()
    
    override func setUp() {
        super.setUp()
        
        voteView = VoteView()
    }
    
    func testVoteViewHasUpvoteDownvoteAndVoteCount() {
        XCTAssertNotNil(voteView.upvoteButton)
        XCTAssertNotNil(voteView.downvoteButton)
        XCTAssertNotNil(voteView.voteCountLabel)
    }
    
    func testVoteViewIsAView() {     
        XCTAssertTrue(voteView.isKind(of: UIView.self))
    }
    
    
}
