//
//  ListingInteractorTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 11/23/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
import RxSwift
@testable import Reddit

class ListingInteractorTest: XCTestCase {
    
    var sut: SubredditInteractor!
    var listingViewController: ListingViewControllerMock!
    var listingUseCase: ListingUseCaseMock!
    var disposeBag: DisposeBag! 
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        listingUseCase = ListingUseCaseMock()
        listingViewController = ListingViewControllerMock()
        sut = SubredditInteractor(presenter: listingViewController, 
                                repository: listingUseCase, 
                                subreddit: "")
    }
    
    // MARK: - Load Next Page Test
    func testShouldNotLoadNextPage() {
        // Given
        let sections: [ListingSection] = [
            ListingSection.linkRows(links: [
                Link(),
                Link(),
                Link()
            ])
        ]
        let indexPath = IndexPath(row: 0, section: 0)

        sut.sections = sections
        
        // When
        let shouldLoad = sut.shouldLoadNextPage(withIndexPath: indexPath)

        // Then
        XCTAssertFalse(shouldLoad)
    }

    func testShouldLoadNextPage() {
        // Given
        let sections: [ListingSection] = [
            ListingSection.linkRows(links: [
                Link(),
                Link(),
                Link()
            ])
        ]

        sut.sections = sections

        // When
        let indexPath = IndexPath(row: 2, section: 0)
        let shouldLoad = sut.shouldLoadNextPage(withIndexPath: indexPath)

        // Then
        XCTAssertTrue(shouldLoad)
    }
    
    func testGetListingNextPageShouldSetInfo() {
        // Given
        sut.after = "qwejn1e21"
        sut.before = "oefhow012"
        sut.subreddit = "Dota2"

        // When
        _ = sut.getListing()

        // Then
        XCTAssertEqual(listingUseCase.subreddit, sut.subreddit)
        XCTAssertEqual(listingUseCase.after, sut.after)
        XCTAssertEqual(listingUseCase.before, sut.before)
    }
    
    func testLoadNextListingPage() {
        // Given
        var listing = Listing()
        let links = [Link(), Link(), Link()]
        listing.children = links
        
        listingUseCase.listing = listing

        sut.sections = [ListingSection.linkRows(links: links)]
        
        let indexPath = IndexPath(row: listing.children.count - 1, section: 0)
        
        // When
        sut.loadNextListingPage(withIndexPath: indexPath)
        
        // Then
        XCTAssertEqual(sut.sections.count, 2)
        XCTAssertTrue(listingViewController.didUpdateListingNextPage)
        XCTAssertFalse(listingViewController.didReloadListing)
    }
    
    // MARK: Load Listing Test
    func testGetListing() {
        // Given
        var listing = Listing()
        listing.children = [Link(), Link(), Link()]

        listingUseCase.listing = listing
        sut.subreddit = "Dota 2"

        // When
        sut.getListing()
            .subscribe(onNext: { (section) in
                switch section {
                    case .linkRows(let links):
                        XCTAssertEqual(listing.children.count, 
                                       links.count)
                }
                
                XCTAssertEqual(self.sut.after, nil)
                XCTAssertEqual(self.sut.before, nil)
            })
            .addDisposableTo(disposeBag)
        
        // Then
        XCTAssertEqual(listingUseCase.subreddit, sut.subreddit)
        XCTAssertEqual(sut.after, nil)
        XCTAssertEqual(sut.before, nil)
    }
    
    func testLoadListingPage() {
        // Given
        var listing = Listing()
        listing.children = [Link(), Link(), Link()]
        
        // When
        sut.loadListingPage()
        
        // Then
        XCTAssertEqual(sut.sections.count, 1)
        XCTAssertTrue(listingViewController.didReloadListing)
        XCTAssertFalse(listingViewController.didUpdateListingNextPage)
    }
}
