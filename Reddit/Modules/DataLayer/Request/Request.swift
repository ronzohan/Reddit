//
//  Request.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

protocol Request {
    var config: RequestConfig { get }
    var endpoint: Endpoint { get }
    var bodyParams: [String: Any] { get }
    
    var fullPath: String { get }
}
