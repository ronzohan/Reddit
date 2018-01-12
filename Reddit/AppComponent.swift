//
//  AppComponent.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    var listingService: SubredditServiceable
    var networkAdapter: NetworkAdapter
    var config: RequestConfig

    init() {
        networkAdapter = AFNetworkAdapter()
        config = RequestConfig(host: "https://www.reddit.com")
        
        listingService = SubredditService(adapter: networkAdapter, config: config)
        super.init(dependency: EmptyComponent())
    }
}
