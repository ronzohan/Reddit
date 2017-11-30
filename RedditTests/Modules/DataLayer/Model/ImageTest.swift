//
//  ImageTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class ImageTest: XCTestCase {
    func testImageParsing() {
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

        guard let json = try? JSONSerialization.data(withJSONObject: imageJSON, options: []) else {
            return
        }
        
        // When i try to parse the json into an Image
        let image = try? JSONDecoder().decode(Image.self, from: json)

        // Then it should have these values
        XCTAssertEqual(image?.id, id)
        XCTAssertEqual(image?.resolutions.count, resolutions.count)
        //XCTAssertEqual(image?.variants.count, variants.count)
        XCTAssertEqual(image?.source.url, imageInfoURL)
        XCTAssertEqual(image?.source.width, imageInfoWidth)
        XCTAssertEqual(image?.source.height, imageInfoHeight)
    }
}
