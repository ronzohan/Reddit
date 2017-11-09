//
//  PreviewImageTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class PreviewImageTest: XCTestCase {

    func testPreviewImageParsing() {
        // Given I have a json
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

        let previewIsEnabled = true
        let previewJSON: [String: Any] = [
            "images": [imageJSON],
            "enabled": previewIsEnabled,
        ]

        // When I parse that json
        let previewImage = PreviewImage(JSON: previewJSON)

        // Then thing mapper thing should have the same value on the json
        XCTAssertEqual(previewImage?.images.count, 1)
        XCTAssertEqual(previewImage?.enabled, previewIsEnabled)
    }
}
