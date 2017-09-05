//
//  Image.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import ObjectMapper

enum ImageKeys: String {
	case source
	case resolutions
	case variants
	case id
}

class Image: Mappable {
	var source: ImageInfo = ImageInfo()
	var resolutions: [ImageInfo] = []
	var variants: [ImageInfo] = []
	var id: String = ""

	init() {}

	required init?(map: Map) {}

	func mapping(map: Map) {
		source <- map[ImageKeys.source.rawValue]
		resolutions <- map[ImageKeys.resolutions.rawValue]
		variants <- map[ImageKeys.variants.rawValue]
		id <- map[ImageKeys.id.rawValue]
	}
}
