//
//  Link.swift
//  DataLayer
//
//  Created by Ron Daryl Magno on 8/13/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//
//  Source: https://github.com/reddit/reddit/wiki/JSON#link-implements-votable--created

import Foundation

struct Link: Votable, Created, Thing, Codable {
    let author: String
    let authorFlairCSSClass: String?
    let authorFlairText: String?
    let clicked: Bool
    let domain: String
    let distinguished: Bool?
    let edited: Float
    let hidden: Bool
    let isSelf: Bool
    let linkFlairCSSClass: String?
    let linkFlairText: String?
    let locked: Bool
    // TODO: var media
    // TODO: var mediaEmbed
    let numComments: Int
    let over18: Bool
    let permalink: String
    let postHint: PostHint?
    let preview: PreviewImage?
    let saved: Bool
    let score: Int
    let selftext: String
    let selftextHTML: String?
    let stickied: Bool
    let subreddit: String
    let subredditID: String
    let title: String
    let subredditNamePrefixed: String
    let thumbnail: String?
    let thumbnailHeight: Float?
    let url: String

    // Thing
    let id: String
    let name: String
    // Votable
    let downs: Int
    let likes: Bool?
    let ups: Int

    // Created
    let created: UInt64
    let createdUTC: UInt64
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorFlairCSSClass = "author_flair_css_class"
        case authorFlairText = "author_flair_text"
        case clicked
        case distinguished
        case domain
        case edited
        case hidden
        case isSelf = "is_self"
        case linkFlairCSSClass = "link_flair_css_class"
        case linkFlairText = "link_flair_text"
        case locked
        case numComments = "num_comments"
        case over18 = "over_18"
        case permalink
        case postHint = "post_hint"
        case preview
        case saved
        case score
        case selftext
        case selftextHTML = "selftext_html"
        case subreddit
        case subredditID = "subreddit_id"
        case subredditNamePrefixed = "subreddit_name_prefixed"
        case stickied
        case thumbnail
        case thumbnailHeight = "thumbnail_height"
        case title
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let thingContainer = try decoder.container(keyedBy: ThingKeys.self)
        let votableContainer = try decoder.container(keyedBy: VotableKeys.self)
        let createdContainer = try decoder.container(keyedBy: CreatedKeys.self)
        
        author = try container.decode(String.self, forKey: .author)
        authorFlairCSSClass = try? container.decode(String.self, forKey: .authorFlairCSSClass)
        authorFlairText = try? container.decode(String.self, forKey: .authorFlairText)
        clicked = try container.decode(Bool.self, forKey: .clicked)
        created = try createdContainer.decode(UInt64.self, forKey: .created)
        createdUTC = try createdContainer.decode(UInt64.self, forKey: .createdUTC)
        domain = try container.decode(String.self, forKey: .domain)
        downs = try votableContainer.decode(Int.self, forKey: .downs)
        distinguished = try? container.decode(Bool.self, forKey: .distinguished)
        edited = try container.decode(Float.self, forKey: .edited)
        hidden = try container.decode(Bool.self, forKey: .hidden)
        id = try thingContainer.decode(String.self, forKey: ThingKeys.id)
        isSelf = try container.decode(Bool.self, forKey: .isSelf)
        likes = try? votableContainer.decode(Bool.self, forKey: VotableKeys.likes)
        linkFlairCSSClass = try? container.decode(String.self, forKey: .linkFlairCSSClass)
        linkFlairText = try? container.decode(String.self, forKey: .linkFlairText)
        locked = try container.decode(Bool.self, forKey: .locked)
        name = try thingContainer.decode(String.self, forKey: .name)
        numComments = try container.decode(Int.self, forKey: .numComments)
        over18 = try container.decode(Bool.self, forKey: .over18)
        permalink = try container.decode(String.self, forKey: .permalink)

        if let hint = try container.decodeIfPresent(String.self, forKey: .postHint) {
            postHint = PostHint(rawValue: hint)
        } else {
            postHint = nil
        }
        
        preview = try container.decodeIfPresent(PreviewImage.self, forKey: .preview)
        saved = try container.decode(Bool.self, forKey: .saved)
        score = try container.decode(Int.self, forKey: .score)
        selftext = try container.decode(String.self, forKey: .selftext)
        selftextHTML = try? container.decode(String.self, forKey: .selftextHTML)
        subreddit = try container.decode(String.self, forKey: .subreddit)
        subredditID = try container.decode(String.self, forKey: .subredditID)
        subredditNamePrefixed = try container.decode(String.self, forKey: .subredditNamePrefixed)
        stickied = try container.decode(Bool.self, forKey: .stickied)
        thumbnail = try? container.decode(String.self, forKey: .thumbnail)
        thumbnailHeight = try? container.decode(Float.self, forKey: .thumbnailHeight)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        ups = try votableContainer.decode(Int.self, forKey: VotableKeys.ups)
    }
}

extension Link: Equatable {}

func == (lhs: Link, rhs: Link) -> Bool {
    return lhs.id == rhs.id
}
