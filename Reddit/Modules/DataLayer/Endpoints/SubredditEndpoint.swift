//
//  SubredditEndpoint.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

enum SubredditEndpoint {
    case hot(subreddit: String)
    case new(subreddit: String)
    case rising(subreddit: String)
}

extension SubredditEndpoint: Endpoint {
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .hot(let subreddit):
            return "/r/\(subreddit)/hot" 
        case .new(let subreddit):
            return "/r/\(subreddit)/new"
        case .rising(let subreddit):
            return "/r/\(subreddit)/rising"
        }
    }
}
