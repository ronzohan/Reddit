//
//  ListingServiceMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 10/26/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
@testable import Reddit
import RxSwift

class ListingServiceMock: ListingUseCase {
    var listing = Listing()

    var subreddit: String?
    var after: String?
    var before: String?
    var didFetchHotListing = false
    func fetchHotListing(subreddit: String, after: String?, before: String?) -> Observable<Listing> {
        didFetchHotListing = true
        self.subreddit = subreddit
        self.after = after
        self.before = before

        return Observable.create({ (observer) -> Disposable in

            observer.onNext(self.listing)

            return Disposables.create()
        })
    }
}
