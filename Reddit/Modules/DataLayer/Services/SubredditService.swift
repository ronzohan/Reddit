//
//  ListingService.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 12/4/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxSwift

protocol SubredditServiceable: Service {
    func newPosts(forSubreddit subreddit: String, bodyParams: [String: Any]) -> Observable<Listing> 
    func hotPosts(forSubreddit subreddit: String, bodyParams: [String: Any]) -> Observable<Listing>
}

class SubredditService: SubredditServiceable {
    var adapter: NetworkAdapter
    var config: RequestConfig

    init(adapter: NetworkAdapter, config: RequestConfig) {
        self.adapter = adapter
        self.config = config
    }

    func newPosts(forSubreddit subreddit: String, bodyParams: [String: Any] = [:]) -> Observable<Listing> {
        let request = RedditRequest(config: config, 
                                    endpoint: SubredditEndpoint.new(subreddit: subreddit),
                                    bodyParams: bodyParams)
        
        return responseModel(forRequest: request)
    }

    func hotPosts(forSubreddit subreddit: String, bodyParams: [String: Any] = [:]) -> Observable<Listing> {
        let request = RedditRequest(config: config, 
                                    endpoint: SubredditEndpoint.hot(subreddit: subreddit),
                                    bodyParams: bodyParams)
        
        return responseModel(forRequest: request)
    }
}
