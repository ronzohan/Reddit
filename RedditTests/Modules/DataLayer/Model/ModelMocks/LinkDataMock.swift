//
//  LinkMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 11/30/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct LinkDataMock {
    static let thingId = "8xwlg"
    static let thingName = "t1_c3v7f8u"
    
    static let author = "Ron"
    static let title = "Witcher"
    static let url = "www.google.com"
    static let authorFlairCSSClass = "rep"
    static let authorFlairText = "IndieGala"
    static let clicked = false
    static let created = 1_505_892_256
    static let createdUTC = 1_505_863_456
    static let domain = "indiegala.com"
    static let downs = 1
    static let edited = true
    static let hidden = true
    static let isSelf = true
    static let likes = true
    static let linkFlairCSSClass = "qwe"
    static let linkFlairText = "sample"
    static let locked = true
    static let numComments = 12
    static let over18 = true
    static let permalink = "www.google.com"
    static let saved = true
    static let score = true
    static let selftext = ""
    static let selftextHTML: String? = nil
    static let subreddit = "pics"
    static let subredditID = "t5_2qwx3"
    static let subredditNamePrefixed = "piasd"
    static let stickied = true
    static let thumbnail = "https://b.thumbs.redditmedia.com/PJySSqTddgw_2nLsIUHeVtsdWBib_25PivYsiQYliaM.jpg"
    static let ups = 100
    
    static let linkData: [String: Any] = [
        "author": author,
        "author_flair_css_class": authorFlairCSSClass,
        "author_flair_text": authorFlairText,
        "clicked": clicked,
        "created": created,
        "created_utc": createdUTC,
        "domain": domain,
        "downs": downs,
        "edited": edited,
        "id": thingId,
        "hidden": hidden,
        "is_self": isSelf,
        "likes": likes,
        "link_flair_css_class": linkFlairCSSClass,
        "link_flair_text": linkFlairText,
        "locked": locked,
        "num_comments": numComments,
        "over_18": over18,
        "permalink": permalink,
        "saved": saved,
        "score": score,
        "selftext": selftext,
        "selftext_html": selftextHTML as Any,
        "subreddit": subreddit,
        "subreddit_id": subredditID,
        "subreddit_name_prefixed": subredditNamePrefixed,
        "stickied": stickied,
        "thumbnail": thumbnail,
        "ups": ups,
        "title": title,
        "url": url,
        "name": thingName
    ]
}
