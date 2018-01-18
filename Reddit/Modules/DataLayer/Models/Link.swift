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
    
    init() {}
    
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
        
        if let hint = try? container.decode(String.self, forKey: .postHint) {
            postHint = PostHint(rawValue: hint) ?? .link
        } else {
            postHint = .link
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
        
        /*self.init(author: author, 
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
                  createdUTC: createdUTC)*/
        
    }
}

extension Link: Equatable {}

func == (lhs: Link, rhs: Link) -> Bool {
    return lhs.id == rhs.id
}
