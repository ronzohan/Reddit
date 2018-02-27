//
//  LinkViewPresenterTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 2/22/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class LinkViewPresenterTest: XCTestCase {
    var link: Link!
    
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
    
    var linkData: [String: Any] = LinkDataMock.linkData
    
    override func setUp() {
        super.setUp()
        
        linkData[Link.CodingKeys.preview.rawValue] = [
            "images": [imageJSON],
            "enabled": true
        ]
        linkData["created_utc"] = 1_505_958_257
        linkData[Link.CodingKeys.title.rawValue] = "[Gamersgate] Tekken 7 ($26.49/%47 OFF), Tekken 7 Deluxe Edition ($43.04/%43 OFF) New Historical Low on Tekken 7"
        linkData[Link.CodingKeys.subredditNamePrefixed.rawValue] = "r/GameDeals"
        linkData[Link.CodingKeys.author.rawValue] = "BigBossTheSnake"
        linkData[Link.CodingKeys.domain.rawValue] = "loadingartist.com"
        
        link = DictionaryHelper.model(for: linkData)
        
        guard let previewImage = link.preview?.images[0] else {
            XCTFail("Preview image is nil")
            return
        }
        
        image = previewImage
    }
    
    // MARK: - Link View Presentation
    func testUrlLinkViewUpdate() {
        // Given
        let view = UrlLinkViewMock()
        
        // When
        LinkViewPresenter.update(urlLinkView: view, with: link)
        
        // Then
        XCTAssertTrue(view.didSetImage)
        XCTAssertTrue(view.didSetMeta)
        XCTAssertTrue(view.didSetUps)
        XCTAssertTrue(view.didSetTitle)
    }
    
    func testUrlLinkViewUpdateWithNoThumbnail() {
        // Given
        let view = UrlLinkViewMock()
        
        // When
        linkData[Link.CodingKeys.thumbnail.rawValue] = nil
        link = DictionaryHelper.model(for: linkData)

        LinkViewPresenter.update(urlLinkView: view, with: link)
        
        // Then
        XCTAssertFalse(view.didSetImage)
        XCTAssertTrue(view.didSetMeta)
        XCTAssertTrue(view.didSetUps)
        XCTAssertTrue(view.didSetTitle)
    }

    // MARK: - Meta
    func testMetaInfo() {
        // Given
        let createdUTC = Date(timeInterval: link.createdUTC)
        guard let expectedIntervalString = Date.timeIntervalString(fromDate: createdUTC, 
                                                                   toDate: Date()) else { 
                                                                    XCTFail("No expected interval string created")
                                                                    return
        }
        
        // When
        let meta = LinkViewPresenter.meta(for: link)
        
        // Then
        let expectedMeta = "\(link.subredditNamePrefixed) • \(expectedIntervalString) • \(link.domain.replacingOccurrences(of: ".com", with: ""))"
        XCTAssertEqual(meta, expectedMeta)
    }
    
    func testMetaDateIsGreaterThanCurrentDate() {
        // Given
        let currentDate = Date()
        
        // When
        linkData["created_utc"] = UInt64(currentDate.timeIntervalSince1970 + 1000)
        link = DictionaryHelper.model(for: linkData)

        let meta = LinkViewPresenter.meta(for: link)

        // Then 
        // the date should not be posted
        let expectedMeta = "\(link.subredditNamePrefixed) • \(link.domain.replacingOccurrences(of: ".com", with: ""))"
        XCTAssertEqual(meta, expectedMeta)
    }
    
    // MARK: - Image Url
    func testRetrievingOfImageUrl() {
        // Given
        // If the preview images is not nil, then the viewModels' imageUrl should
        // also not be nil
        XCTAssertNotNil(link.preview?.images)

        // When
        let url = LinkViewPresenter.imageUrl(for: link)
        
        // Then
        XCTAssertNotNil(url)
    }
    
    func testRetrievingOfImageUrlWithEmptyResolutions() {
        // Given
        let imageJSON: [String: Any] = [
            "source": imageInfoJSON,
            "resolutions": [],
            "id": "123qwe"
        ]
        
        linkData["preview"] = [
            "images": [imageJSON],
            "enabled": true
        ]
        
        link = DictionaryHelper.model(for: linkData)
        
        // When
        let url = LinkViewPresenter.imageUrl(for: link)
        
        // Then
        XCTAssertNil(url)
    }
    
    
    // MARK: - Cell Height
    func testCellHeightForWidthWithSameFrameWidth() {
        // Given
        let frameWidth: Double = 250
        
        // When
        let cellHeight = LinkViewPresenter.contentHeight(forWidth: frameWidth, link: link)
        
        // Then height should be this value
        let expectedHeight = image.resolutions[0].height * (frameWidth / image.resolutions[0].width)
        XCTAssertEqual(expectedHeight, cellHeight)
    }
    
    func testCellHeightForWidthWithManyImages() {
        // Given
        let frameWidth: Double = 210
        let imageInfo2Height: Double = 150
        let imageInfo2Width: Double = 200
        
        imageJSON[Image.CodingKeys.resolutions.rawValue] = [
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
        
        linkData[Link.CodingKeys.preview.rawValue] = [
            PreviewImage.CodingKeys.images.rawValue: [imageJSON],
            PreviewImage.CodingKeys.enabled.rawValue: true
        ]
        
        link = DictionaryHelper.model(for: linkData)

        // When
        let cellHeight = LinkViewPresenter.contentHeight(forWidth: frameWidth, link: link)
        
        // Then
        let expectedCellHeight = imageInfo2Height * (frameWidth / imageInfo2Width)
        XCTAssertEqual(expectedCellHeight, 
                       cellHeight)
    }
    
    func testCellHeightForWidthWithPreviewDisabled() {
        // Given
        let frameWidth: Double = 200
        
        linkData[Link.CodingKeys.preview.rawValue] = [
            PreviewImage.CodingKeys.images.rawValue: [imageJSON],
            PreviewImage.CodingKeys.enabled.rawValue: false
        ]
        
        link = DictionaryHelper.model(for: linkData)
        
        // When
        let cellHeight = LinkViewPresenter.contentHeight(forWidth: frameWidth, link: link)
        
        // Then
        XCTAssertEqual(cellHeight, 
                       LinkViewPresenter.minimumCellHeight)
    }
    
    func testCellHeightWithNoPreviewImage() {
        // Given
        let frameWidth: Double = 200
        
        // When
        let cellHeight = LinkViewPresenter.contentHeight(forWidth: frameWidth, link: link)
        
        // Then
        XCTAssertEqual(cellHeight, 
                       LinkViewPresenter.minimumCellHeight)
    }
    
    // MARK: - Posthint
    func testPostHint() {
        // Given
        let postHint: PostHint = .image
        
        // When
        linkData[Link.CodingKeys.postHint.rawValue] = postHint.rawValue
        link = DictionaryHelper.model(for: linkData)
        
        // Then
        let hint = LinkViewPresenter.postHint(for: link)
        XCTAssertEqual(hint, link.postHint)
    }
}
