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

class SubredditInteractorTest: XCTestCase {
    
    var sut: SubredditInteractor!
    var subredditViewController: SubredditViewControllerMock!
    var subredditService: SubredditServiceMock!
    var link: Link!
    var disposeBag: DisposeBag! 
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        subredditService = SubredditServiceMock()
        subredditViewController = SubredditViewControllerMock()
        sut = SubredditInteractor(presenter: subredditViewController, 
                                  service: subredditService, 
                                  subreddit: "")
        
        link = DictionaryHelper.model(for: LinkDataMock.linkData)
    }
    
    // MARK: - Load Next Page Test
    func testShouldNotLoadNextPage() {
        // Given
        let sections: [SubredditSection] = [
            SubredditSection.linkRows(links: [
                link,
                link,
                link
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
        let sections: [SubredditSection] = [
            SubredditSection.linkRows(links: [
                link,
                link,
                link
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
        XCTAssertEqual(subredditService.subreddit, sut.subreddit)
        XCTAssertEqual(subredditService.params["after"] as? String, sut.after)
        XCTAssertEqual(subredditService.params["before"] as? String, sut.before)
    }
    
    func testLoadNextListingPage() {
        // Given
        var listing = Listing()
        let links: [Link] = [link, link, link]
        listing.children = links
        
        subredditService.listing = listing

        sut.sections = [SubredditSection.linkRows(links: links)]
        
        let indexPath = IndexPath(row: listing.children.count - 1, section: 0)
        
        // When
        sut.loadNextListingPage(withIndexPath: indexPath)
        
        // Then
        XCTAssertEqual(sut.sections.count, 2)
        XCTAssertTrue(subredditViewController.didAddListingNextPage)
        XCTAssertFalse(subredditViewController.didReloadListing)
    }
    
    // MARK: Load Listing Test
    func testGetListing() {
        // Given
        var listing = Listing()
        listing.children = [link, link, link]

        subredditService.listing = listing
        sut.subreddit = "Dota 2"

        // When
        sut.getListing()
            .subscribe(onNext: { (section) in
                switch section {
                case .linkRows(let links):
                    XCTAssertEqual(listing.children.count, 
                                       links.count)
                case .loadingIndicator:
                    break
                }
                
                XCTAssertEqual(self.sut.after, nil)
                XCTAssertEqual(self.sut.before, nil)
            })
            .addDisposableTo(disposeBag)
        
        // Then
        XCTAssertEqual(subredditService.subreddit, sut.subreddit)
        XCTAssertEqual(sut.after, nil)
        XCTAssertEqual(sut.before, nil)
    }
    
    func testLoadListingPage() {
        // Given
        var listing = Listing()
        listing.children = [link, link, link]
        
        // When
        sut.loadListingPage()
        
        // Then
        XCTAssertEqual(sut.sections.count, 1)
        XCTAssertTrue(subredditViewController.didReloadListing)
        XCTAssertFalse(subredditViewController.didAddListingNextPage)
    }
}
