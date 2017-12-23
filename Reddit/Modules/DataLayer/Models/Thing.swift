//
//  Thing.swift
//  DataLayer
//
//  Created by Ron Daryl Magno on 8/13/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//
// Source: https://github.com/reddit/reddit/wiki/JSON#thing-reddit-base-class

import Foundation

enum ThingKeys: String, CodingKey {
    case id
    case name
    case data
    case kind
}

protocol Thing {
    var id: String { get set }
    var name: String { get set }
}
