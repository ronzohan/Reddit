//
//  RedditRequest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class RedditRequest: Request {
    var config: RequestConfig
    var endpoint: Endpoint
    var bodyParams: [String: Any] {
        // Always append raw_json in the body in all request
        params["raw_json"] = 1
        
        return params
    }
    
    private var params: [String: Any]
    
    var fullPath: String {
        return "\(config.host)\(endpoint.path).json"
    }
    
    init(config: RequestConfig, endpoint: Endpoint, bodyParams: [String: Any] = [:]) {
        self.config = config
        self.endpoint = endpoint
        self.params = bodyParams
    }
}
