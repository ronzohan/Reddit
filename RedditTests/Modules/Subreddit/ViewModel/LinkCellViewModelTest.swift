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
    lazy var link: Link = Link()
    lazy var viewModel = LinkCellViewModel(link: link)

    override func setUp() {
        super.setUp()

        link = Link()
        link.title = "A 19 year old Sofia Vergara"
        link.subredditNamePrefixed = "r/pics"
        link.createdUTC = 1_506_946_298
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

    // MARK: - Image Url
    
    func testRetrievingOfImageUrl() {
        let imageInfo = ImageInfo(url: "google.com", 
                                  width: 200, 
                                  height: 100)

        let image = Image(source: imageInfo, 
                          resolutions: [imageInfo], 
                          id: "")

        link.preview.images = [image]

        XCTAssertNotNil(viewModel.imageUrl)
    }

    func testRetrievingOfImageUrlWithEmptyResolutions() {
        var image = Image()
        image.resolutions = []

        link.preview.images = [image]

        XCTAssertNil(viewModel.imageUrl)
    }
    
    
    // MARK: - Cell Height
    func testCellHeightForWidth() {
        // Given
        let frameWidth: Double = 250
        
        var image = Image()
        var imageInfo = ImageInfo()
        imageInfo.height = 100
        imageInfo.width = frameWidth
        imageInfo.url = "google.com"
        image.resolutions = [imageInfo]
        
        link.preview.images = [image] 

        // When
        let cellHeight = viewModel.cellHeight(for: frameWidth)
        
        // Then
        // Width should be this value
        
        XCTAssertEqual(cellHeight, imageInfo.height)
    }
    
    func testCellHeightForWidthWithManyImages() {
        // Given
        let frameWidth: Double = 210
        
        var image = Image()
        var imageInfo = ImageInfo()
        imageInfo.height = 100
        imageInfo.width = 200
        imageInfo.url = "google.com"
        
        var imageInfo2 = ImageInfo()
        imageInfo2.height = 200
        imageInfo2.width = 150
        
        image.resolutions = [imageInfo, imageInfo2]
        
        link.preview.images = [image] 
        link.preview.enabled = true
        
        // When
        let cellHeight = viewModel.cellHeight(for: frameWidth)
        
        // Then
        let expectedCellHeight = imageInfo2.height * (frameWidth / imageInfo2.width)
        XCTAssertEqual(expectedCellHeight, 
                       cellHeight)
    }
    
    func testCellHeightForWidthWithPreviewDisabled() {
        // Given
        let frameWidth: Double = 200
        
        var image = Image()
        var imageInfo = ImageInfo()
        imageInfo.height = 100
        imageInfo.width = 200
        imageInfo.url = "google.com"
        
        image.resolutions = [imageInfo]
        
        link.preview.images = [image] 
        link.preview.enabled = false
        
        // When
        let cellHeight = viewModel.cellHeight(for: frameWidth)

        // Then
        XCTAssertEqual(cellHeight, 
                       viewModel.minimumCellHeight)
    }
    
    func testCellHeightWithNoPreviewImage() {
        // Given
        let frameWidth: Double = 200
        
        // When
        let cellHeight = viewModel.cellHeight(for: frameWidth)
        
        // Then
        XCTAssertEqual(cellHeight, 
                       viewModel.minimumCellHeight)
    }
    
    // MARK: - Posthint
    
    func testPostHint() {
        // Given
        let postHint: PostHint = .image
        
        // When
        link.postHint = postHint
        
        // Then
        XCTAssertEqual(viewModel.postHint, link.postHint)
    }
}
