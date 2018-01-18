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
    var link: Link!
    lazy var viewModel = LinkCellViewModel(link: link)

    var image: Image!
    
    lazy var imageInfoJSON: [String: Any] = [
        "url": "google.com",
        "height": 100,
        "width": 200
    ]
    
    lazy var imageJSON: [String: Any] = [
        "source": self.imageInfoJSON,
        "resolutions": [self.imageInfoJSON],
        "id": "123qwe"
    ]
    
    override func setUp() {
        super.setUp()
        
        var linkData: [String: Any] = LinkDataMock.linkData
        linkData["preview"] = [
            "images": [imageJSON],
            "enabled": true
        ]

        link = DictionaryHelper.model(for: linkData)
        link.title = "A 19 year old Sofia Vergara"
        link.subredditNamePrefixed = "r/pics"
        link.createdUTC = 1_506_946_298
        link.domain = "i.imgur.com"

        guard let previewImage = link.preview?.images[0] else {
            XCTFail("Preview image is nil")
            return
        }

        image = previewImage
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
        link.preview?.images = [image]

        XCTAssertNotNil(viewModel.imageUrl)
    }

    func testRetrievingOfImageUrlWithEmptyResolutions() {
        let imageJSON: [String: Any] = [
            "source": imageInfoJSON,
            "resolutions": [],
            "id": "123qwe"
        ]
        
        image = DictionaryHelper.model(for: imageJSON)
        link.preview?.images = [image]

        XCTAssertNil(viewModel.imageUrl)
    }
    
    
    // MARK: - Cell Height
    func testCellHeightForWidthWithSameFrameWidth() {
        // Given
        let frameWidth: Double = 250

        // When
        let cellHeight = viewModel.cellHeight(for: frameWidth)
        
        // Then height should be this value
        let expectedHeight = image.resolutions[0].height * (frameWidth / image.resolutions[0].width)
        XCTAssertEqual(expectedHeight, cellHeight)
    }
    
    func testCellHeightForWidthWithManyImages() {
        // Given
        let frameWidth: Double = 210
        let imageInfo2Height: Double = 150
        let imageInfo2Width: Double = 200

        imageJSON["resolutions"] = [
            [
                "url": "google.com",
                "width": 200,
                "height": 100
            ],
            [
                "url": "google.com",
                "width": imageInfo2Width,
                "height": imageInfo2Height
            ]
        ]

        image = DictionaryHelper.model(for: imageJSON)
        
        link.preview?.images = [image] 
        link.preview?.enabled = true
        
        // When
        let cellHeight = viewModel.cellHeight(for: frameWidth)
        
        // Then
        let expectedCellHeight = imageInfo2Height * (frameWidth / imageInfo2Width)
        XCTAssertEqual(expectedCellHeight, 
                       cellHeight)
    }
    
    func testCellHeightForWidthWithPreviewDisabled() {
        // Given
        let frameWidth: Double = 200

        link.preview?.images = [image] 
        link.preview?.enabled = false
        
        // When
        let cellHeight = viewModel.cellHeight(for: frameWidth)

        // Then
        XCTAssertEqual(cellHeight, 
                       LinkCellViewModel.minimumCellHeight)
    }
    
    func testCellHeightWithNoPreviewImage() {
        // Given
        let frameWidth: Double = 200
        
        // When
        let cellHeight = viewModel.cellHeight(for: frameWidth)
        
        // Then
        XCTAssertEqual(cellHeight, 
                       LinkCellViewModel.minimumCellHeight)
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
