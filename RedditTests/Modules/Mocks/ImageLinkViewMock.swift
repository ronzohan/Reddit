//
//  ImageLinkViewMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 3/2/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
@testable import Reddit

class ImageLinkViewMock: ImageLinkViewable {
    var width: Double = 0
    
    var didSetImage = false
    func setImage(withUrl url: String) {
        didSetImage = true  
    }
    
    var didSetTitle = false
    func setTitle(withTitle title: String) {
        didSetTitle = true
    }
    
    var didSetUps = false
    func setUps(withUps ups: String) {
        didSetUps = true
    }
    
    var didSetMeta = false
    func setMeta(withMeta meta: String) {
        didSetMeta = true
    }
    
    var didSetContentHeight = false
    func setContentHeight(height: Double) {
        didSetContentHeight = true
    }
    
    
}
