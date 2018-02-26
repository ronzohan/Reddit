////
////  LinkCellViewModelTest.swift
////  RedditTests
////
////  Created by Ron Daryl Magno on 10/4/17.
////  Copyright © 2017 Ron Daryl Magno. All rights reserved.
////
//
//import XCTest
//@testable import Reddit
//
//class LinkCellViewModelTest: XCTestCase {
//    var link: Link!
//    var viewModel: LinkCellViewModel!
//
//    var image: Image!
//    
//    lazy var imageInfoJSON: [String: Any] = [
//        "url": "google.com",
//        "height": 100,
//        "width": 200
//    ]
//    
//    lazy var imageJSON: [String: Any] = [
//        "source": self.imageInfoJSON,
//        "resolutions": [self.imageInfoJSON],
//        "id": "123qwe"
//    ]
//    
//    var linkData: [String: Any] = LinkDataMock.linkData
//    
//    override func setUp() {
//        super.setUp()
//
//        linkData[Link.CodingKeys.preview.rawValue] = [
//            "images": [imageJSON],
//            "enabled": true
//        ]
//        linkData["created_utc"] = 1_505_958_257
//        linkData[Link.CodingKeys.title.rawValue] = "[Gamersgate] Tekken 7 ($26.49/%47 OFF), Tekken 7 Deluxe Edition ($43.04/%43 OFF) New Historical Low on Tekken 7"
//        linkData[Link.CodingKeys.subredditNamePrefixed.rawValue] = "r/GameDeals"
//        linkData[Link.CodingKeys.author.rawValue] = "BigBossTheSnake"
//        linkData[Link.CodingKeys.domain.rawValue] = "loadingartist.com"
//        
//        link = DictionaryHelper.model(for: linkData)
//
//        guard let previewImage = link.preview?.images[0] else {
//            XCTFail("Preview image is nil")
//            return
//        }
//
//        image = previewImage
//        
//        viewModel = LinkCellViewModel(link: link)
//    }
//
//    func testMetaInfo() {
//        guard let expectedIntervalString = Date.timeIntervalString(
//            fromDate: Date(timeInterval: link.createdUTC),
//            toDate: Date()
//        ) else {
//            assert(false)
//        }
//
//        XCTAssertEqual(viewModel.title, link.title)
//        XCTAssertEqual(
//            viewModel.meta,
//            "\(link.subredditNamePrefixed) • \(expectedIntervalString) • \(link.domain.replacingOccurrences(of: ".com", with: ""))"
//        )
//    }
//
//    func testMetaDateIsGreaterThanCurrentDate() {
//        // Given
//        let currentDate = NSDate()
//        
//        // When
//        linkData["created_utc"] = UInt64(currentDate.timeIntervalSince1970 + 1000)
//        link = DictionaryHelper.model(for: linkData)
//        
//        viewModel = LinkCellViewModel(link: link)
//        // Then 
//        // the date should not be posted
//        XCTAssertEqual(
//            viewModel.meta,
//            "\(link.subredditNamePrefixed) • \(link.domain.replacingOccurrences(of: ".com", with: ""))"
//        )
//    }
//
//    // MARK: - Image Url
//
//    func testRetrievingOfImageUrl() {
//        // If the preview images is not nil, then the viewModels' imageUrl should
//        // also not be nil
//        XCTAssertNotNil(link.preview?.images)
//        XCTAssertNotNil(viewModel.imageUrl)
//    }
//
//    func testRetrievingOfImageUrlWithEmptyResolutions() {
//        let imageJSON: [String: Any] = [
//            "source": imageInfoJSON,
//            "resolutions": [],
//            "id": "123qwe"
//        ]
//
//        linkData["preview"] = [
//            "images": [imageJSON],
//            "enabled": true
//        ]
//        
//        link = DictionaryHelper.model(for: linkData)
//        viewModel = LinkCellViewModel(link: link)
//        XCTAssertNil(viewModel.imageUrl)
//    }
//    
//    
//    // MARK: - Cell Height
//    func testCellHeightForWidthWithSameFrameWidth() {
//        // Given
//        let frameWidth: Double = 250
//
//        // When
//        let cellHeight = viewModel.cellHeight(for: frameWidth)
//        
//        // Then height should be this value
//        let expectedHeight = image.resolutions[0].height * (frameWidth / image.resolutions[0].width)
//        XCTAssertEqual(expectedHeight, cellHeight)
//    }
//    
//    func testCellHeightForWidthWithManyImages() {
//        // Given
//        let frameWidth: Double = 210
//        let imageInfo2Height: Double = 150
//        let imageInfo2Width: Double = 200
//
//        imageJSON[Image.CodingKeys.resolutions.rawValue] = [
//            [
//                "url": "google.com",
//                "width": 200,
//                "height": 100
//            ],
//            [
//                "url": "google.com",
//                "width": imageInfo2Width,
//                "height": imageInfo2Height
//            ]
//        ]
//
//        linkData[Link.CodingKeys.preview.rawValue] = [
//            PreviewImage.CodingKeys.images.rawValue: [imageJSON],
//            PreviewImage.CodingKeys.enabled.rawValue: true
//        ]
//    
//        link = DictionaryHelper.model(for: linkData)
//
//        viewModel = LinkCellViewModel(link: link)
//        // When
//        let cellHeight = viewModel.cellHeight(for: frameWidth)
//        
//        // Then
//        let expectedCellHeight = imageInfo2Height * (frameWidth / imageInfo2Width)
//        XCTAssertEqual(expectedCellHeight, 
//                       cellHeight)
//    }
//    
//    func testCellHeightForWidthWithPreviewDisabled() {
//        // Given
//        let frameWidth: Double = 200
//
//        linkData[Link.CodingKeys.preview.rawValue] = [
//            PreviewImage.CodingKeys.images.rawValue: [imageJSON],
//            PreviewImage.CodingKeys.enabled.rawValue: false
//        ]
//        
//        link = DictionaryHelper.model(for: linkData)
//        viewModel = LinkCellViewModel(link: link)
//        
//        // When
//        let cellHeight = viewModel.cellHeight(for: frameWidth)
//
//        // Then
//        XCTAssertEqual(cellHeight, 
//                       LinkCellViewModel.minimumCellHeight)
//    }
//    
//    func testCellHeightWithNoPreviewImage() {
//        // Given
//        let frameWidth: Double = 200
//        
//        // When
//        let cellHeight = viewModel.cellHeight(for: frameWidth)
//        
//        // Then
//        XCTAssertEqual(cellHeight, 
//                       LinkCellViewModel.minimumCellHeight)
//    }
//    
//    // MARK: - Posthint
//    
//    func testPostHint() {
//        // Given
//        let postHint: PostHint = .image
//        
//        // When
//        linkData[Link.CodingKeys.postHint.rawValue] = postHint.rawValue
//        link = DictionaryHelper.model(for: linkData)
//        viewModel = LinkCellViewModel(link: link)
//        
//        // Then
//        XCTAssertEqual(viewModel.postHint, link.postHint)
//    }
//}

