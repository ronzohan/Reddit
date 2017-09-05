//
//  PreviewImages.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import ObjectMapper

enum PreviewImageKeys: String {
	case images
	case enabled
}

class PreviewImage: Mappable {
	var images: [Image] = []
	var enabled: Bool = false

	init() {}

	required init?(map: Map) {}

	func mapping(map: Map) {
		images <- map[PreviewImageKeys.images.rawValue]
		enabled <- map[PreviewImageKeys.enabled.rawValue]
	}
}
