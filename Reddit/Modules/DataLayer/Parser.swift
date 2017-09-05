//
//  Parser.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/18/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import ObjectMapper

class Parser {
	static func parseAny(json: [String: Any]) -> Any? {
		if let dataKind = json[ThingKeys.kind.rawValue] as? String,
		   let kind = Kind(rawValue: dataKind),
		   let data = json[ThingKeys.data.rawValue] as? [String: Any] {

			return ThingFactory.parseAny(Data: data, withKind: kind)
		} else {
			return nil
		}
	}
}

class ThingFactory {
	static func parseAny(Data data: [String: Any], withKind kind: Kind) -> Any? {
		switch kind {
		case .link:
			return Link(JSON: data)
		case .listing:
			return Listing(JSON: data)
		}

	}
}
