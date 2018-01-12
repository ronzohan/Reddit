//
//  ListingServiceMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 10/26/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxSwift
@testable import Reddit

class NetworkAdapterMock: NetworkAdapter {
    var request: Request?

    func execute(request: Request, completionHandler: @escaping (Response<Data>) -> Void) {
        self.request = request
    }
}

class SubredditServiceMock: SubredditServiceable {
    var adapter: NetworkAdapter = AFNetworkAdapter() as! NetworkAdapter
    
    var params: [String: Any] = [:]
    
    var subreddit: String?
    
    var listing: Listing?
    
    var didFetchNewPosts = false
    func newPosts(forSubreddit subreddit: String, bodyParams: [String : Any]) -> Observable<Listing> {
        didFetchNewPosts = true
        params = bodyParams
        self.subreddit = subreddit
        
        return Observable.just(listing ?? Listing())
    }
    
    var didFetchHotPosts = false
    func hotPosts(forSubreddit subreddit: String, bodyParams: [String : Any]) -> Observable<Listing> {
        didFetchHotPosts = true
        params = bodyParams
        self.subreddit = subreddit
        
        return Observable.just(listing ?? Listing())
    }
}
