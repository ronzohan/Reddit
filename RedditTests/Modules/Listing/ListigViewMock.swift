//
//  ListigViewMock.swift
//  Listing
//
//  Created by Ron Daryl Magno on 8/11/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
@testable import Reddit

class ListingViewMock: IListingView {
    var setListingsDidCall = false
	
	func setListingSection(section: [ListingSection]) {
		setListingsDidCall = true
	}
}
