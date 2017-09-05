//
//  Created.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/19/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

enum CreatedKeys: String {
	case created
	case createdUTC
}

protocol Created {
	var created: UInt64 { get }
	var createdUTC: UInt64 { get }
}
