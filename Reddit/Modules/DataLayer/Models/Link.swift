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
	case title
	case url
	case authorFlairCSSClass = "author_flair_css_class"
	case thumbnail
	case thumbnailHeight = "thumbnail_height"
	case preview
}

class Link: Votable, Created, Thing, Mappable {
	var kind: Kind = .link

	var id: String = ""
	var name: String = ""
    var author: String?
    var title: String = ""
    var url: String = ""
    var authorFlairCSSClass: String?
	var thumbnail: String?
	var thumbnailHeight: Double = 0
	var preview: PreviewImage = PreviewImage()

	// Votable
	var ups: Int = 0
	var downs: Int = 0
	var likes: Bool = false

	// Created
	var created: UInt64 = 0
	var createdUTC: UInt64 = 0

	init() {}

	required init?(map: Map) {}

	func mapping(map: Map) {
		id <- map[ThingKeys.id.rawValue]
		name <- map[ThingKeys.name.rawValue]

		author <- map[LinkKeys.author.rawValue]
		title <- map[LinkKeys.title.rawValue]
		url <- map[LinkKeys.url.rawValue]
		authorFlairCSSClass <- map[LinkKeys.authorFlairCSSClass.rawValue]
		thumbnail <- map[LinkKeys.thumbnail.rawValue]
		thumbnailHeight <- map[LinkKeys.thumbnailHeight.rawValue]
		preview <- map[LinkKeys.preview.rawValue]

		// Votable
		ups <- map[VotableKeys.ups.rawValue]
		downs <- map[VotableKeys.downs.rawValue]
		likes <- map[VotableKeys.likes.rawValue]

		// Created
		created <- map[CreatedKeys.created.rawValue]
		createdUTC <- map[CreatedKeys.createdUTC.rawValue]
	}
}

extension Link: Equatable {}

func == (lhs: Link, rhs: Link) -> Bool {
	return lhs.id == rhs.id
}
