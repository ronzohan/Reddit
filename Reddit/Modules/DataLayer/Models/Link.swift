//
//  Link.swift
//  DataLayer
//
//  Created by Ron Daryl Magno on 8/13/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//
//  Source: https://github.com/reddit/reddit/wiki/JSON#link-implements-votable--created

import Foundation
import ObjectMapper

enum LinkKeys: String {
	case author
	case authorFlairCSSClass = "author_flair_css_class"
	case authorFlairText = "author_flair_text"
	case clicked
	case domain
	case hidden
	case isSelf = "is_self"
	case linkFlairCSSClass = "link_flair_css_class"
	case linkFlairText = "link_flair_text"
	case locked
	case numComments = "num_comments"
	case over18 = "over_18"
	case permalink
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

class Link: Votable, Created, Thing, Mappable {
    var author: String = ""
	var authorFlairCSSClass: String?
	var authorFlairText: String?
	var clicked: Bool = false
	var domain: String = ""
	var distinguished = false
	var edited: Bool = false
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
	var preview: PreviewImage = PreviewImage()
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
	var thumbnailHeight: Double = 0
	var url: String = ""

	// Thing
	var id: String = ""
	var kind: Kind = .link
	var name: String = ""

	// Votable
	var downs: Int = 0
	var likes: Bool?
	var ups: Int = 0

	// Created
	var created: UInt64 = 0
	var createdUTC: UInt64 = 0

	init() {}

	required init?(map: Map) {}

	func mapping(map: Map) {
		id <- map[ThingKeys.id.rawValue]
		name <- map[ThingKeys.name.rawValue]

		author <- map[LinkKeys.author.rawValue]
		authorFlairCSSClass <- map[LinkKeys.authorFlairCSSClass.rawValue]
		authorFlairText <- map[LinkKeys.authorFlairText.rawValue]
		clicked <- map[LinkKeys.clicked.rawValue]
		domain <- map[LinkKeys.domain.rawValue]
		hidden <- map[LinkKeys.hidden.rawValue]
		isSelf <- map[LinkKeys.isSelf.rawValue]
		linkFlairCSSClass <- map[LinkKeys.linkFlairCSSClass.rawValue]
		linkFlairText <- map[LinkKeys.linkFlairText.rawValue]
		locked <- map[LinkKeys.locked.rawValue]
		numComments <- map[LinkKeys.numComments.rawValue]
		over18 <- map[LinkKeys.over18.rawValue]
		permalink <- map[LinkKeys.permalink.rawValue]
		preview <- map[LinkKeys.preview.rawValue]
		saved <- map[LinkKeys.saved.rawValue]
		score <- map[LinkKeys.score.rawValue]
		selftext <- map[LinkKeys.selftext.rawValue]
		selftextHTML <- map[LinkKeys.selftextHTML.rawValue]
		subredditNamePrefixed <- map[LinkKeys.subredditNamePrefixed.rawValue]
		stickied <- map[LinkKeys.stickied.rawValue]
		subreddit <- map[LinkKeys.subreddit.rawValue]
		subredditID <- map[LinkKeys.subredditID.rawValue]
		title <- map[LinkKeys.title.rawValue]
		thumbnail <- map[LinkKeys.thumbnail.rawValue]
		thumbnailHeight <- map[LinkKeys.thumbnailHeight.rawValue]
		url <- map[LinkKeys.url.rawValue]

		// Votable
		downs <- map[VotableKeys.downs.rawValue]
		likes <- map[VotableKeys.likes.rawValue]
		ups <- map[VotableKeys.ups.rawValue]

		// Created
		created <- map[CreatedKeys.created.rawValue]
		createdUTC <- map[CreatedKeys.createdUTC.rawValue]
	}
}

extension Link: Equatable {}

func == (lhs: Link, rhs: Link) -> Bool {
	return lhs.id == rhs.id
}
