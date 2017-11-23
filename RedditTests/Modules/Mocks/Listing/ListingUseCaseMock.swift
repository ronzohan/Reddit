//
//  ListingUseCaseMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 11/23/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxSwift
@testable import Reddit

class ListingUseCaseMock: ListingUseCase {
    var listing: Listing?
    var subreddit: String?
    var after: String?
    var before: String?
    func fetchHotListing(subreddit: String,
                         after: String?,
                         before: String?) -> Observable<Listing> {
        self.subreddit = subreddit
        self.after = after
        self.before = before

        return Observable.just(listing ?? Listing())
    }
}
