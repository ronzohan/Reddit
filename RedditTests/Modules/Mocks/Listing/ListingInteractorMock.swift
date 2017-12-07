//
//  ListingInteractorMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 11/23/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
@testable import Reddit

class ListingInteractorMock: SubredditPresentableListener {
    var sections: [ListingSection] = []
    
    var didLoadNextListingPage = false
    func loadNextListingPage(withIndexPath indexPath: IndexPath) {
        didLoadNextListingPage = true
    }
    
    var didSelectItem = false
    func didSelectItem(atIndexPath indexPath: IndexPath) {
        didSelectItem = true
    }
}
