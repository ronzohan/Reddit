//
//  EndpointMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 12/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
@testable import Reddit

enum EndpointMock {
    case getEndpoint
    case postEndpoint
}

extension EndpointMock: Endpoint {
    var getEndpoint: String { return "/get" }
    var postEndpoint: String { return "/post" }
    
    var path: String {
        switch self {
        case .getEndpoint:
            return getEndpoint
        case .postEndpoint:
            return postEndpoint
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getEndpoint:
            return .get
        case .postEndpoint:
            return .post
        }
    }
}
