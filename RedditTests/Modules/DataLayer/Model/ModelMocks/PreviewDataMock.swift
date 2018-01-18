//
//  PreviewDataMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 1/19/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct PreviewDataMock {
    static let imageInfoJSON: [String: Any] = [
        "url": "google.com",
        "height": 100,
        "width": 200
    ]
    
    static let imageJSON: [String: Any] = [
        "source": PreviewDataMock.imageInfoJSON,
        "resolutions": [PreviewDataMock.imageInfoJSON],
        "id": "123qwe"
    ]
    
    static let previewData: [String: Any] = [
        "images": [PreviewDataMock.imageJSON],
        "enabled": true
    ]
}
