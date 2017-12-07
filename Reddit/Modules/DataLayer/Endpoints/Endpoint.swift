//
//  Request.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/1/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case get
    case post
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
}
