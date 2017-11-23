////
////  ListingViewModelTest.swift
////  RedditTests
////
////  Created by Ron Daryl Magno on 11/7/17.
////  Copyright © 2017 Ron Daryl Magno. All rights reserved.
////
//
//import XCTest
//import RxSwift
//@testable import Reddit
//
//class ListingViewModelTest: XCTestCase {
//
//    var sut: ListingViewModel!
//    var listingService: ListingServiceMock!
//    let disposeBag = DisposeBag()
//
//    override func setUp() {
//        super.setUp()
//        listingService = ListingServiceMock()
//        sut = ListingViewModel(useCase: listingService)
//    }
//

//
//    func testGetListingNextPage() {
//        // Given
//        sut.after = "qwejn1e21"
//        sut.before = "oefhow012"
//        sut.subreddit = "Dota2"
//
//        // When
//        _ = sut.getListing()
//
//        // Then
//        XCTAssertEqual(listingService.subreddit, sut.subreddit)
//        XCTAssertEqual(listingService.after, sut.after)
//        XCTAssertEqual(listingService.before, sut.before)
//    }
//}

