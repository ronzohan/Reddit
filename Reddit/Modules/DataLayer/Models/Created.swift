//
//  Created.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/19/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

enum CreatedKeys: String, CodingKey {
    case created
    case createdUTC = "created_utc"
}

protocol Created: Codable {
    var created: UInt64 { get }
    var createdUTC: UInt64 { get }
}
