//
//  CommentDataMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 1/17/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct CommentDataMock {
    static let archived = true
    static let author = "Ron"
    static let bannedAtUTC: UInt64 = 12312739 //?
    static let bannedBy = "ronzohan" //?
    static let body = "*Beep boop*, I am a bot, *darn it*.\n***\n^^Darn ^^Counter: ^^930"
    static let bodyHTML = "<div class=\"md\"><p><em>Beep boop</em>, I am a bot, <em>darn it</em>.</p>\n\n<hr/>\n\n<p><sup><sup>Darn</sup></sup> <sup><sup>Counter:</sup></sup> <sup><sup>930</sup></sup></p>\n</div>"
    static let canGild = true
    static let canModPost = true
    static let collapsed = true
    static let controversiality = 0
    static let created: UInt64 = 1516140270
    static let createdUTC: UInt64 = 1516111470
    static let depth = 9
    static let downs = 10
    static let edited = true
    static let gilded = 0
    static let id = "id"
    static let isSubmitter = true
    static let linkID = "t3_7qri8q"
    static let modReasonTitle = "Some title" //?
    static let name = "t1_dsrhuxt"
    static let parentID = "t1_dsrhtrt"
    static let permalink = "/r/gaming/comments/7qri8q/had_a_20_minute_costume_competition_i_knew_from/dsrhuxt/"
    static let removalReason = "nothing" //?
    static let saved = true
    static let score = 76
    static let scoreHidden = true
    static let stickied = true
    static let subreddit = "gaming"
    static let subredditNamePrefixed = "r/gaming"
    static let ups = 10
    static let subredditID = "t5_2qh03"
    
    static let CommentData: [String: Any] = [
        "archived": archived,
        "author": author,
        "banned_at_utc": bannedAtUTC,
        "banned_by": bannedBy,
        "body": body,
        "body_html": bodyHTML,
        "can_gild": canGild,
        "can_mod_post": canModPost,
        "collapsed": collapsed,
        "controversiality": controversiality,
        "created": created,
        "created_utc": createdUTC,
        "depth": depth,
        "downs": downs,
        "edited": edited,
        "gilded": gilded,
        "id": id,
        "is_submitter": isSubmitter,
        "link_id": linkID,
        "mod_reason_title": modReasonTitle,
        "name": name,
        "parent_id": parentID,
        "permalink": permalink,
        "removal_reason": removalReason,
        "saved": saved,
        "score": score,
        "score_hidden": scoreHidden,
        "stickied": stickied,
        "subreddit": subreddit,
        "subreddit_name_prefixed": subredditNamePrefixed,
        "ups": ups,
        "subreddit_id": subredditID
    ]
}
