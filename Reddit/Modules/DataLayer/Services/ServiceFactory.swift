//
//  ServiceFactory.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class ServiceFactory {
    private static var networkConfig: RequestConfig = RequestConfig(host: "https://www.reddit.com")
    private static var networkAdapter: NetworkAdapter = AFNetworkAdapter()
    
    static func makeSubredditService() -> SubredditService {
        return SubredditService(adapter: networkAdapter, config: networkConfig)
    }
}
