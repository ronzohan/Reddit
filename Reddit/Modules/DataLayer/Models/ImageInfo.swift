//
//  ImageInfo.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import ObjectMapper

enum ImageInfoKeys: String {
	case url
	case width
	case height
}

class ImageInfo: Mappable {
	var url: String = ""
	var width: Double = 0
	var height: Double = 0

	init() {}

	required init?(map: Map) {

	}

	func mapping(map: Map) {
		url <- map[ImageInfoKeys.url.rawValue]
		width <- map[ImageInfoKeys.width.rawValue]
		height <- map[ImageInfoKeys.height.rawValue]
	}
}
