//
//  ListingSections.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/16/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

enum ListingSectionType {
	case link
}

protocol ListingSection {
	var type: ListingSectionType { get }
	var rowCount: Int { get }
}
