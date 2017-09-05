//
//  Listing.swift
//  DataLayer
//
//  Created by Ron Daryl Magno on 8/13/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//
//  Source: https://github.com/reddit/reddit/wiki/JSON#listing

import Foundation
import ObjectMapper

enum ListingKeys: String {
	case after = "after"
	case before = "before"
	case modHash = "modhash"
	case children = "children"
	case data = "data"
	case kind = "kind"
}

class Listing: Mappable {
	var kind: Kind = .listing
	var modHash: String = ""
	var after: String?
	var before: String?
	var children: [Thing] = []

	init() {}

	required init?(map: Map) {

	}

	func mapping(map: Map) {
		if let kindString: String = try? map.value(ListingKeys.kind.rawValue),
		   let kind = Kind(rawValue: kindString) {
			self.kind = kind
		}

		guard let dataJSON = try? map.value(ListingKeys.data.rawValue) as [String: Any] else {
			return
		}

		let dataMap = Map(mappingType: .fromJSON, JSON: dataJSON)

		self.after = dataMap.JSON[ListingKeys.after.rawValue] as? String
		self.before = dataMap.JSON[ListingKeys.before.rawValue] as? String

		if let modhash = dataMap.JSON[ListingKeys.modHash.rawValue] as? String {
			self.modHash = modhash
		}

		if let children = dataMap.JSON[ListingKeys.children.rawValue] as? [[String: Any]] {
			self.children = children.flatMap({ (child) -> Thing? in
				return Parser.parseAny(json: child) as? Thing
			})
		}
	}

}
