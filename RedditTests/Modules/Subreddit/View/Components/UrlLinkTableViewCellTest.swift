//
//  UrlLinkTableViewCellTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 10/4/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class UrlLinkTableViewCellTest: XCTestCase {
    func testUrlLinkTableViewCellPrepareForReuse() {
        let sut = UrlLinkTableViewCell()

        sut.linkView.contentView.image = UIImage()
        sut.prepareForReuse()

        XCTAssertNil(sut.linkView.contentView.image)
        XCTAssertEqual(sut.linkView.mainContentViewHeightConst?.constant, 0)
    }

    func testUrlLinkTableViewCellConfigure() {
        class UrlLinkTableViewCellMock: UrlLinkTableViewCell {
            var didUpdateImage = false
            override func updateImage(withURLRequest request: URLRequest) {
                super.updateImage(withURLRequest: request)
                didUpdateImage = true
            }
        }

        // Given
        let imageInfoURL = "https://i.redditmedia.com/E4hzETVQUOqY_G4V4rzjlokV8rP8u5zcYe29L5szwmM.gif?fm=jpg&s=09e53dd4ba18cd921ba7b375f02663a1"
        let imageInfoWidth: Double = 250
        let imageInfoHeight: Double = 444

        let imageInfo: [String: Any] = [
            "url": imageInfoURL,
            "width": imageInfoWidth,
            "height": imageInfoHeight,
        ]

        let id = "6x3asd"

        let resolutions = [imageInfo, imageInfo]
        let variants = [imageInfo, imageInfo]

        let imageJSON: [String: Any] = [
            "source": imageInfo,
            "resolutions": resolutions,
            "variants": variants,
            "id": id,
        ]

        // When i try to parse the json into an Image
        var linkData = LinkDataMock.linkData
        linkData[Link.CodingKeys.preview.rawValue] = [
            PreviewImage.CodingKeys.images.rawValue: [imageJSON],
            PreviewImage.CodingKeys.enabled.rawValue: true
        ]

        guard let link: Link = DictionaryHelper.model(for: linkData) else {
            XCTFail("Failed to create link")
            return
        }

        let viewModel = LinkCellViewModel(link: link)

        let sut = UrlLinkTableViewCellMock()
        sut.viewModel = viewModel
        sut.configure()

        // Then
        //XCTAssertEqual(sut.linkView.mode, .horizontal)
        XCTAssertEqual(
            sut.linkView.mainContentViewHeightConst?.constant,
            100
        )
        XCTAssertTrue(sut.didUpdateImage)
    }
}
