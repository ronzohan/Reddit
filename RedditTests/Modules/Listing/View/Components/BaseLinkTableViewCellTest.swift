//
//  BaseLinkTableViewCellTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 10/2/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class BaseLinkTableViewCellTest: XCTestCase {
    var sut: LinkTableViewCell<UIView>!

    override func setUp() {
        super.setUp()

        sut = LinkTableViewCell<UIView>()
    }

    func testConfigureCell() {
        let link = Link()
        link.title = "A 19 year old Sofia Vergara"
        link.subredditNamePrefixed = "r/pics"
        link.createdUTC = 1_506_946_298
        link.domain = "i.imgur.com"

        let viewModel = LinkCellViewModel(link: link)

        sut.viewModel = viewModel
        sut.configure()

        guard let expectedIntervalString = Date.timeIntervalString(
            fromDate: Date(timeInterval: link.createdUTC),
            toDate: Date()
        ) else {
            XCTFail("No interval string found.")
            return
        }

        XCTAssertEqual(sut.linkView.metaLabel.text, "r/pics • \(expectedIntervalString) • i.imgur")
        XCTAssertEqual(sut.linkView.titleLabel.text, link.title)
    }

    func testCellLinkContent() {
        let cell = LinkTableViewCell<UIImageView>()

        XCTAssertTrue(type(of: cell.linkView.contentView) == type(of: UIImageView()))
    }

    func testOnMetaTapped() {
        var callBackCalled = false
        let tapped = {
            callBackCalled = true
        }

        sut.onMetaTapped(tapped)
        sut.onMetaLabelTappedHandler(sender: nil)

        XCTAssertTrue(callBackCalled)
    }

    func testOnContentTapped() {
        var callBackCalled = false
        let tapped = {
            callBackCalled = true
        }

        sut.onContentTapped(tapped)
        sut.onContentTappedHandler(sender: nil)

        XCTAssertTrue(callBackCalled)
    }

    func testOnUpvoteTapped() {
        var callBackCalled = false
        let tapped = {
            callBackCalled = true
        }

        sut.onUpVoteTapped(tapped)
        sut.onUpVoteTappedHandler(sender: nil)

        XCTAssertTrue(callBackCalled)
    }

    func testOnDownvoteTapped() {
        var callBackCalled = false
        let tapped = {
            callBackCalled = true
        }

        sut.onDownVoteTapped(tapped)
        sut.onDownVoteTappedHandler(sender: nil)

        XCTAssertTrue(callBackCalled)
    }
}
