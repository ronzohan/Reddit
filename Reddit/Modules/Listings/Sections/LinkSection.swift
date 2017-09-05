//
//  LinkSection.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct LinkSection: ListingSection {
	var rowCount: Int { return links.count }
	var type: ListingSectionType { return .link }

	var links: [Link]

}
