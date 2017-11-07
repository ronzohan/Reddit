//
//  ListingViewModelTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 11/7/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
import RxSwift
@testable import Reddit

class ListingViewModelTest: XCTestCase {
    
	var sut: ListingViewModel!
	var listingService: ListingServiceMock!
	let disposeBag = DisposeBag() 
	
    override func setUp() {
		super.setUp()
		listingService = ListingServiceMock()
		sut = ListingViewModel(useCase: listingService)
    }
	
	func testGetListing() {
		// Given
		let listing = Listing()
		listing.children = [Link(), Link(), Link()]
		
		listingService.listing = listing
		sut.subreddit = "Dota2"
		
		// When
		sut.getListing()
			.subscribe(onNext: { (sections) in
				// Then
				if case let ListingSection.linkRows(rows) = sections {
					XCTAssertEqual(rows.count, 3)
				} else {
					XCTFail("No listing section found.")
				}
				
				XCTAssertEqual(self.sut.after, listing.after)
				XCTAssertEqual(self.sut.before, listing.before)
			})
			.addDisposableTo(disposeBag)
		
		XCTAssertEqual(listingService.subreddit, sut.subreddit)
		XCTAssertNil(listingService.after)
		XCTAssertNil(listingService.before)
	}
	
	func testGetListingNextPage() {
		// Given
		sut.after = "qwejn1e21"
		sut.before = "oefhow012"
		sut.subreddit = "Dota2"
		
		// When
		_ = sut.getListing()
		
		// Then
		XCTAssertEqual(listingService.subreddit, sut.subreddit)
		XCTAssertEqual(listingService.after, sut.after)
		XCTAssertEqual(listingService.before, sut.before)
	}
}
