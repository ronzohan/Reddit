//
//  Comment.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 1/17/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct Comment: Votable, Created, Thing, Codable {
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
    let linkID: String
    let modReasonTitle: String?
    let name: String
    let parentID: String
    let permalink: String
    let removalReason: String?
    let saved: Bool
    let score: Int
    let scoreHidden: Bool
    let stickied: Bool
    let subreddit: String
    let subredditNamePrefixed: String
    let ups: Int
    let subredditID: String
    
    enum CodingKeys: String, CodingKey {
        case archived
        case author
        case bannedAtUTC = "banned_at_utc"
        case bannedBy = "banned_by"
        case body
        case bodyHTML = "body_html"
        case canGild = "can_gild"
        case canModPost = "can_mod_post"
        case collapsed
        case controversiality
        case created
        case createdUTC = "created_utc"
        case depth
        case downs
        case edited
        case gilded
        case id
        case isSubmitter = "is_submitter"
        case likes
        case linkID = "link_id"
        case modReasonTitle = "mod_reason_title"
        case name
        case parentID = "parent_id"
        case permalink
        case removalReason = "removal_reason"
        case saved
        case score
        case scoreHidden = "score_hidden"
        case stickied
        case subreddit
        case subredditNamePrefixed = "subreddit_name_prefixed"
        case ups
        case subredditID = "subreddit_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        archived = try container.decode(Bool.self, forKey: .archived)
        author = try container.decode(String.self, forKey: .author)
        bannedAtUTC = try? container.decode(UInt64.self, forKey: .bannedAtUTC)
        bannedBy = try? container.decode(String.self, forKey: .bannedBy)
        body = try container.decode(String.self, forKey: .body)
        bodyHTML = try container.decode(String.self, forKey: .bodyHTML)
        canGild = try container.decode(Bool.self, forKey: .canGild)
        canModPost = try container.decode(Bool.self, forKey: .canModPost)
        collapsed = try container.decode(Bool.self, forKey: .collapsed)
        controversiality = try container.decode(Int.self, forKey: .controversiality)
        created = try container.decode(UInt64.self, forKey: .created)
        createdUTC = try container.decode(UInt64.self, forKey: .createdUTC)
        depth = try container.decode(Int.self, forKey: .depth)
        downs = try container.decode(Int.self, forKey: .downs)
        edited = try container.decode(Bool.self, forKey: .edited)
        gilded = try container.decode(Int.self, forKey: .gilded)
        id = try container.decode(String.self, forKey: .id)
        isSubmitter = try container.decode(Bool.self, forKey: .isSubmitter)
        likes = try? container.decode(Bool.self, forKey: .likes)
        linkID = try container.decode(String.self, forKey: .linkID)
        modReasonTitle = try? container.decode(String.self, forKey: .modReasonTitle)
        name = try container.decode(String.self, forKey: .name)
        parentID = try container.decode(String.self, forKey: .parentID)
        permalink = try container.decode(String.self, forKey: .permalink)
        removalReason = try? container.decode(String.self, forKey: .removalReason)
        saved = try container.decode(Bool.self, forKey: .saved)
        score = try container.decode(Int.self, forKey: .score)
        scoreHidden = try container.decode(Bool.self, forKey: .scoreHidden)
        stickied = try container.decode(Bool.self, forKey: .stickied)
        subreddit = try container.decode(String.self, forKey: .subreddit)
        subredditNamePrefixed = try container.decode(String.self, forKey: .subredditNamePrefixed)
        ups = try container.decode(Int.self, forKey: .ups)
        subredditID = try container.decode(String.self, forKey: .subredditID)
    }
}
