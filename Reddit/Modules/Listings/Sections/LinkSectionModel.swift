//
//  ListingSections.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/16/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxDataSources

enum LinkItem {
	case urlLink(link: Link)
	case imageLink(link: Link)
}

enum LinkSectionModel: SectionModelType {
	typealias Item = LinkItem

	var items: [LinkItem] {
		switch self {
		case .linkSection(let items):
			return items
		}
	}

	init(original: LinkSectionModel, items: [LinkItem]) {
		switch original {
		case let .linkSection(items):
			self = .linkSection(items: items)
		}
	}

	case linkSection(items: [LinkItem])
}
