//
//  CaptionImageView.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 3/5/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class CaptionedImageViewTest: XCTestCase {
    func testSettingCaption() {
        // Given
        let captionedImageView = CaptionedImageView()
        let caption = "www.google.com"
        
        // When
        captionedImageView.caption = caption
        
        // Then
        XCTAssertEqual(captionedImageView.captionLabel.text, caption)
    }
    
    func testCaptionIsVisible() {
        // Given
        let imageView: CaptionedImageView
        
        // When
        imageView = CaptionedImageView()
        
        // Then
        XCTAssertEqual(imageView.captionLabel.superview, imageView)
    }
}
