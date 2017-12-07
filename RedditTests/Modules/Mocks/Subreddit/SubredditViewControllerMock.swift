//
//  ListingViewControllerMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 11/23/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RIBs
@testable import Reddit

class SubredditViewControllerMock: SubredditPresentable {
    weak var listener: SubredditPresentableListener?

    var didReloadListing = false
    func reloadListing() {
        didReloadListing = true
    }
    
    var didUpdateListingNextPage = false
    func updateListingNextPage() {
        didUpdateListingNextPage = true
    }
}
