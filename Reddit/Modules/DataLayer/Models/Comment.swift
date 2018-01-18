//
//  Comment.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 1/17/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct Comment: Votable, Created, Thing {
    let archived: Bool
    let author: String
    let bannedAtUTC: UInt64?
    let bannedBy: String?
    let body: String
    let bodyHTML: String
    let canGild: Bool
    let canModPost: Bool
    let collapsed: Bool
    let controversiality: Int
    let created: UInt64
    let createdUTC: UInt64
    let depth: Int
    let downs: Int
    let edited: Bool
    let gilded: Int
    let id: String
    let isSubmitter: Bool
    let likes: Bool?
    let linkID: String = "t3_7qri8q"
    let modReasonTitle: String? = "Some title" //?
    let name: String = "t1_dsrhuxt"
    let parentID: String = "t1_dsrhtrt"
    let permalink: String = "/r/gaming/comments/7qri8q/had_a_20_minute_costume_competition_i_knew_from/dsrhuxt/"
    let removalReason: String? = "nothing" //?
    let saved: Bool = true
    let score: Int = 76
    let scoreHidden: Bool = true
    let stickied: Bool = true
    let subreddit: String = "gaming"
    let subredditNamePrefixed: String = "r/gaming"
    let ups: Int = 10
    let subredditID: String = "t5_2qh03"
}
