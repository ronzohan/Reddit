//
//  ServiceFactory.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class ServiceFactory {
    static var networkConfig: RequestConfig = RequestConfig(host: "https://www.reddit.com")
    static var networkAdapter: NetworkAdapter = AFNetworkAdapter()
    
    static func makeSubredditService() -> SubredditService {
        return SubredditService(with: networkAdapter, config: networkConfig)
    }
}
