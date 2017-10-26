//
//  LinkCellViewModelTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 10/4/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class LinkCellViewModelTest: XCTestCase {
	var link = Link()
	lazy var viewModel = LinkCellViewModel(link: link)
	
	override func setUp() {
		super.setUp()
		
		link.title = "A 19 year old Sofia Vergara"
		link.subredditNamePrefixed = "r/pics"
		link.createdUTC = 1506946298
		link.domain = "i.imgur.com"
	}
	
	func testMetaInfo() {
		guard let expectedIntervalString = Date.timeIntervalString(
			fromDate: Date(timeInterval: link.createdUTC),
			toDate: Date()
			) else {
				assert(false)
		}

		XCTAssertEqual(viewModel.title, link.title)
		XCTAssertEqual(
			viewModel.meta,
			"r/pics • \(expectedIntervalString) • i.imgur"
		)
		XCTAssertNil(viewModel.imageUrl)
	}

	func testMetaDateIsGreaterThanCurrentDate() {
		let currentDate = NSDate()

		link.createdUTC = UInt64(currentDate.timeIntervalSince1970 + 1000)

		XCTAssertEqual(
			viewModel.meta,
			"r/pics • i.imgur"
		)
	}
	
	func testRetrievingOfImageUrl() {
		let image = Image()
		let imageInfo = ImageInfo()
		imageInfo.height = 100
		imageInfo.width = 200
		imageInfo.url = "google.com"
		image.resolutions = [imageInfo]
		
		link.preview.images = [image]
		
		XCTAssertNotNil(viewModel.imageUrl)
	}
	
	func testRetrievingOfImageUrlWithEmptyResolutions() {
		let image = Image()
		let imageInfo = ImageInfo()
		imageInfo.height = 100
		imageInfo.width = 200
		imageInfo.url = "google.com"
		image.resolutions = []
		
		link.preview.images = [image]
		
		XCTAssertNil(viewModel.imageUrl)
	}
}
