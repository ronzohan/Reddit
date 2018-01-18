//
//  Link.swift
//  DataLayer
//
//  Created by Ron Daryl Magno on 8/13/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//
//  Source: https://github.com/reddit/reddit/wiki/JSON#link-implements-votable--created

import Foundation

struct Link: Votable, Created, Thing {
    var author: String = ""
    var authorFlairCSSClass: String?
    var authorFlairText: String?
    var clicked: Bool = false
    var domain: String = ""
    var distinguished: Bool? = false
    var edited: Float = 0
    var hidden: Bool = false
    var isSelf: Bool = false
    var linkFlairCSSClass: String?
    var linkFlairText: String?
    var locked: Bool = false
    // TODO: var media
    // TODO: var mediaEmbed
    var numComments: Int = 0
    var over18: Bool = false
    var permalink: String = ""
    var postHint: PostHint = .link
    var preview: PreviewImage?
    var saved: Bool = false
    var score: Int = 0
    var selftext: String = ""
    var selftextHTML: String?
    var stickied: Bool = false
    var subreddit: String = ""
    var subredditID: String = ""
    var title: String = ""
    var subredditNamePrefixed: String = ""
    var thumbnail: String?
    var thumbnailHeight: Float? = 0
    var url: String = ""

    // Thing
    var id: String = ""
    var name: String = ""

    // Votable
    var downs: Int = 0
    var likes: Bool?
    var ups: Int = 0

    // Created
    var created: UInt64 = 0
    var createdUTC: UInt64 = 0
}

extension Link: Decodable {
    enum LinkKeys: String, CodingKey {
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
        let container = try decoder.container(keyedBy: LinkKeys.self)
        let thingContainer = try decoder.container(keyedBy: ThingKeys.self)
        let votableContainer = try decoder.container(keyedBy: VotableKeys.self)
        let createdContainer = try decoder.container(keyedBy: CreatedKeys.self)
        
        let author = try container.decode(String.self, forKey: .author)
        let authorFlairCSSClass = try? container.decode(String.self, forKey: .authorFlairCSSClass)
        let authorFlairText = try? container.decode(String.self, forKey: .authorFlairText)
        let clicked = try container.decode(Bool.self, forKey: .clicked)
        let created = try createdContainer.decode(UInt64.self, forKey: .created)
        let createdUTC = try createdContainer.decode(UInt64.self, forKey: .createdUTC)
        let domain = try container.decode(String.self, forKey: .domain)
        let downs = try votableContainer.decode(Int.self, forKey: .downs)
        let distinguished = try? container.decode(Bool.self, forKey: .distinguished)
        let edited = try container.decode(Float.self, forKey: .edited)
        let hidden = try container.decode(Bool.self, forKey: .hidden)
        let id = try thingContainer.decode(String.self, forKey: ThingKeys.id)
        let isSelf = try container.decode(Bool.self, forKey: .isSelf)
        let likes = try? votableContainer.decode(Bool.self, forKey: VotableKeys.likes)
        let linkFlairCSSClass = try? container.decode(String.self, forKey: .linkFlairCSSClass)
        let linkFlairText = try? container.decode(String.self, forKey: .linkFlairText)
        let locked = try container.decode(Bool.self, forKey: .locked)
        let name = try thingContainer.decode(String.self, forKey: .name)
        let numComments = try container.decode(Int.self, forKey: .numComments)
        let over18 = try container.decode(Bool.self, forKey: .over18)
        let permalink = try container.decode(String.self, forKey: .permalink)
        
        let postHint: PostHint
        
        if let hint = try? container.decode(String.self, forKey: .postHint) {
            postHint = PostHint(rawValue: hint) ?? .link
        } else {
            postHint = .link
        }
        
        let preview = try container.decodeIfPresent(PreviewImage.self, forKey: .preview)
        let saved = try container.decode(Bool.self, forKey: .saved)
        let score = try container.decode(Int.self, forKey: .score)
        let selftext = try container.decode(String.self, forKey: .selftext)
        let selftextHTML = try? container.decode(String.self, forKey: .selftextHTML)
        let subreddit = try container.decode(String.self, forKey: .subreddit)
        let subredditID = try container.decode(String.self, forKey: .subredditID)
        let subredditNamePrefixed = try container.decode(String.self, forKey: .subredditNamePrefixed)
        let stickied = try container.decode(Bool.self, forKey: .stickied)
        let thumbnail = try? container.decode(String.self, forKey: .thumbnail)
        let thumbnailHeight = try? container.decode(Float.self, forKey: .thumbnailHeight)
        let title = try container.decode(String.self, forKey: .title)
        let url = try container.decode(String.self, forKey: .url)
        let ups = try votableContainer.decode(Int.self, forKey: VotableKeys.ups)
        
        self.init(author: author, 
                  authorFlairCSSClass: authorFlairCSSClass, 
                  authorFlairText: authorFlairText, 
                  clicked: clicked, 
                  domain: domain, 
                  distinguished: distinguished, 
                  edited: edited, 
                  hidden: hidden, 
                  isSelf: isSelf, 
                  linkFlairCSSClass: linkFlairCSSClass, 
                  linkFlairText: linkFlairText, 
                  locked: locked, 
                  numComments: numComments, 
                  over18: over18, 
                  permalink: permalink, 
                  postHint: postHint, 
                  preview: preview, 
                  saved: saved, 
                  score: score, 
                  selftext: selftext, 
                  selftextHTML: selftextHTML, 
                  stickied: stickied, 
                  subreddit: subreddit, 
                  subredditID: subredditID, 
                  title: title, 
                  subredditNamePrefixed: subredditNamePrefixed, 
                  thumbnail: thumbnail, 
                  thumbnailHeight: thumbnailHeight, 
                  url: url, 
                  id: id, 
                  name: name, 
                  downs: downs, 
                  likes: likes, 
                  ups: ups, 
                  created: created, 
                  createdUTC: createdUTC)
        
    }
}

extension Link: Equatable {}

func == (lhs: Link, rhs: Link) -> Bool {
    return lhs.id == rhs.id
}
