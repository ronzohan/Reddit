//
//  Votable.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/19/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

enum VotableKeys: String, CodingKey {
    case ups
    case downs
    case likes
}

protocol Votable: Codable {
    var ups: Int { get }
    var downs: Int { get }
    var likes: Bool? { get }
}
