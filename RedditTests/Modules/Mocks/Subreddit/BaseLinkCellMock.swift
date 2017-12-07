//
//  BaseLinkCellMock.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 11/23/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
@testable import Reddit

class BaseLinkCellMock: BaseLinkTableViewCell {
    var didConfigure = false
    override func configure() {
        didConfigure = true
    }
}