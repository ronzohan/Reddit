//
//  ILinkCellMock.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
@testable import Reddit

class LinkCellMock: ILinkCell {
	
	var updateCellHeightCalled = false
	func updateCellHeight(height: Double) {
		updateCellHeightCalled = true
	}

	var updateImageCalled = false
	func updateImage(withURLRequest request: URLRequest?) {
		updateImageCalled = true
	}
	
	var updateTitleCalled = false
	func updateTitle(title: String) {
		updateTitleCalled = true
	}
}
