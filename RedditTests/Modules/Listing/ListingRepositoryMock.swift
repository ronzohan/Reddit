//
//  ListingRepositoryMock.swift
//  Listing
//
//  Created by Ron Daryl Magno on 8/11/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
@testable import Reddit


class ListingRepositoryMock: IListingRepository {
    var loadHotListingDidcall = false
	
	func loadHotListing(listingCompletion listing: @escaping (Listing) -> Void) {
		loadHotListingDidcall = true
		
		listing(Listing())
	}
}

