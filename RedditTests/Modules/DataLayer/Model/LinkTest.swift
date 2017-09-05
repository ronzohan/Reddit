//
//  LinkTest.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/15/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit
import ObjectMapper

class LinkTest: XCTestCase {
	
	var link: Link!
	
	override func setUp() {
		super.setUp()
	}

	func testJSONToLink() {
		// Given I have a json
		let thingId = "8xwlg"
		let thingName = "t1_c3v7f8u"
		
		let linkAuthor = "Ron"
		let linkTitle = "Witcher"
		let linkUrl = "www.google.com"
		
		let linkData = [
			"author": linkAuthor,
			"title": linkTitle,
			"url": linkUrl,
			"id": thingId,
			"name": thingName
		]
		
		// When I parse that json
		link = Link(JSON: linkData)
		
		// Then thing mapper thing should have the same value on the json
		XCTAssertEqual(link.author, linkAuthor)
		XCTAssertEqual(link.title, linkTitle)
		XCTAssertEqual(link.url, linkUrl)
	}
	
	func testInitForLink() {
		// Given I have a link
		let link: Link
		let linkJSON: Link?
		
		// When I init the link to its blank init
		link = Link()
		linkJSON = Link(JSON: [:])
		
		// Then it should have default values
		XCTAssertEqual(link, linkJSON)
	}
}
