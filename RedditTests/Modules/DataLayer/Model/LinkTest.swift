//
//  LinkTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/15/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit
import ObjectMapper

class LinkTest: XCTestCase {

    var link: Link!

    override func setUp() {
        super.setUp()
    }

    func testJSONToLink() {
        // Given I have a json
        let thingId = "8xwlg"
        let thingName = "t1_c3v7f8u"

        let author = "Ron"
        let title = "Witcher"
        let url = "www.google.com"
        let authorFlairCSSClass = "rep"
        let authorFlairText = "IndieGala"
        let clicked = false
        let created = 1_505_892_256
        let createdUTC = 1_505_863_456
        let domain = "indiegala.com"
        let down = 1
        let edited = true
        let hidden = true
        let isSelf = true
        let likes = true
        let linkFlairCSSClass = "qwe"
        let linkFlairText = "sample"
        let locked = true
        let numComments = 12
        let over18 = true
        let permalink = "www.google.com"
        let saved = true
        let score = true
        let selftext = ""
        let selftextHTML: String? = nil
        let subreddit = "pics"
        let subredditID = "t5_2qwx3"
        let thumbnail = "https://b.thumbs.redditmedia.com/PJySSqTddgw_2nLsIUHeVtsdWBib_25PivYsiQYliaM.jpg"

        let linkData: [String: Any] = [
            "author": author,
            "author_flair_css_class": authorFlairCSSClass,
            "author_flair_text": authorFlairText,
            "clicked": clicked,
            "created": created,
            "created_utc": createdUTC,
            "domain": domain,
            "down": down,
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
            "thumbnail": thumbnail,
            "title": title,
            "url": url,
            "name": thingName,
        ]

        // When I parse that json
        link = Link(JSON: linkData)

        // Then thing mapper thing should have the same value on the json
        XCTAssertEqual(link.author, author)
        XCTAssertEqual(link.title, title)
        XCTAssertEqual(link.url, url)
    }

    func testInitForLink() {
        // Given I have a link
        let link: Link
        let linkJSON: Link?

        // When I init the link to its blank init
        link = Link()
        linkJSON = Link(JSON: [:])

        // Then it should have default values
        XCTAssertEqual(link, linkJSON)
    }
}
