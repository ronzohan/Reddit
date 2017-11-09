//
//  Votable.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/19/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

enum VotableKeys: String {
    case ups
    case downs
    case likes
}

protocol Votable {
    var ups: Int { get }
    var downs: Int { get }
    var likes: Bool? { get }
}
