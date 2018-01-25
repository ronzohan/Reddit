//
//  CommentTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 1/17/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class CommentTest: XCTestCase {
    func testCommentMapping() {
        // Given
        let commentData = CommentDataMock.CommentData
        
        // When
        guard let comment: Comment = DictionaryHelper.model(for: commentData) else {
            XCTFail("Failed to parse comment data")
            return
        }
        
        // Then
        XCTAssertEqual(comment.archived, CommentDataMock.archived)
        XCTAssertEqual(comment.author, CommentDataMock.author)
        XCTAssertEqual(comment.bannedAtUTC, CommentDataMock.bannedAtUTC)
        XCTAssertEqual(comment.bannedBy, CommentDataMock.bannedBy)
        XCTAssertEqual(comment.body, CommentDataMock.body)
        XCTAssertEqual(comment.bodyHTML, CommentDataMock.bodyHTML)
        XCTAssertEqual(comment.canGild, CommentDataMock.canGild)
        XCTAssertEqual(comment.canModPost, CommentDataMock.canModPost)
        XCTAssertEqual(comment.collapsed, CommentDataMock.collapsed)
        XCTAssertEqual(comment.controversiality, CommentDataMock.controversiality)
        XCTAssertEqual(comment.created, CommentDataMock.created)
        XCTAssertEqual(comment.createdUTC, CommentDataMock.createdUTC)
        XCTAssertEqual(comment.depth, CommentDataMock.depth)
        XCTAssertEqual(comment.downs, CommentDataMock.downs)
        XCTAssertEqual(comment.edited, CommentDataMock.edited)
        XCTAssertEqual(comment.gilded, CommentDataMock.gilded)
        XCTAssertEqual(comment.id, CommentDataMock.id)
        XCTAssertEqual(comment.isSubmitter, CommentDataMock.isSubmitter)
        XCTAssertEqual(comment.linkID, CommentDataMock.linkID)
        XCTAssertEqual(comment.modReasonTitle, CommentDataMock.modReasonTitle)
        XCTAssertEqual(comment.name, CommentDataMock.name)
        XCTAssertEqual(comment.parentID, CommentDataMock.parentID)
        XCTAssertEqual(comment.permalink, CommentDataMock.permalink)
        XCTAssertEqual(comment.removalReason, CommentDataMock.removalReason)
        XCTAssertEqual(comment.saved, CommentDataMock.saved)
        XCTAssertEqual(comment.score, CommentDataMock.score)
        XCTAssertEqual(comment.scoreHidden, CommentDataMock.scoreHidden)
        XCTAssertEqual(comment.subreddit, CommentDataMock.subreddit)
        XCTAssertEqual(comment.subredditNamePrefixed, CommentDataMock.subredditNamePrefixed)
        XCTAssertEqual(comment.ups, CommentDataMock.ups)
        XCTAssertEqual(comment.subredditID, CommentDataMock.subredditID)
    }
}
