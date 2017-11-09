//
//  ListingViewControllerTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 10/26/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class ListingViewControllerTest: XCTestCase {
	var sut: ListingViewController!
	var viewModel: ListingViewModel!
	var service: ListingServiceMock!

	override func setUp() {
		service = ListingServiceMock()
		viewModel = ListingViewModel(useCase: service)
		sut = ListingViewController(viewModel: viewModel)
		
		XCTAssertNotNil(sut.view)
	}
	
	func testViewDidLoadShouldGetListing() {
		// Given
		// When
		sut.viewDidLoad()
		
		// Then
		XCTAssertEqual(service.subreddit, "all")
	}
	
	func testLoadNextPage() {
		// Given
		let links = [Link(), Link(), Link()]
		let indexPath = IndexPath(row: 2, section: 0)
		let listing = Listing()
		listing.children = [Link()]

		// When
		sut.datasources.dataSource = [ListingSection.linkRows(links: links)]
		sut.listingTableView.reloadData()

		service.listing = listing
	
		// Then		
		XCTAssertEqual(sut.datasources.dataSource.count, 1)
		_ = sut.datasources.tableView(sut.listingTableView, willDisplay: UITableViewCell(), forRowAt: indexPath)

		XCTAssertEqual(sut.datasources.dataSource.count, 2)
	}
}
