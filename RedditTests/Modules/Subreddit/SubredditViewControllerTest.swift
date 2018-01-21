//
//  ListingViewControllerTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 10/26/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class SubredditViewControllerTest: XCTestCase {
    var sut: SubredditViewController!
    var interactor: SubredditInteractorMock!
    var link: Link!
    
    override func setUp() {
        super.setUp()

        interactor = SubredditInteractorMock()

        sut = SubredditViewController()
        sut.listener = interactor
        
        link = DictionaryHelper.model(for: LinkDataMock.linkData)
        
        XCTAssertNotNil(sut?.view)
    }
    
    // MARK: - Cell Tests
    func testLinkTableCellIsConfigured() {
        // Given
        let cell = BaseLinkCellMock()

        // When
        sut.configureLinkTableViewCell(cell: cell, link: link)

        // Then
        XCTAssertTrue(cell.didConfigure)
    }
    
    func testUrlLinkTableViewCell() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        let cell: UrlLinkTableViewCell?

        // When
        cell = sut.urlLinkTableViewCellFor(tableView: sut.tableView, indexPath: indexPath)

        // Then
        XCTAssertNotNil(cell)
    }
    
    func testImageLinkTableViewCell() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        let cell: ImageLinkTableViewCell?

        // When
        cell = sut.imageLinkTableViewCellFor(tableView: sut.tableView, indexPath: indexPath)

        // Then
        XCTAssertNotNil(cell)
    }

    // MARK: - Load Listing Test
    func testLoadListingWithNoItems() {
        // Given
        sut.listener = nil
        
        // When
        sut.tableView.reloadData()
        
        // Then
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
    }
    
    func testReloadListing() {
        // Given
        let links: [Link] = [link, link, link]
        let sections = [SubredditSection.linkRows(links: links)]
        interactor.sections = sections
        
        // When
        sut.reloadListing()
        
        // Then
        XCTAssertEqual(sut.numberOfSections(in: sut.tableView), sections.count)
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), links.count)
    }
    
    // MARK: - Load Next Page Test
    func testLoadNextPage() {
        // Given
        let links: [Link] = [link, link, link]
        let indexPath = IndexPath(row: 2, section: 0)
        
        // When
        interactor.sections = [SubredditSection.linkRows(links: links)]
        sut.listener = interactor
        
        sut.tableView.reloadData()
        
        // Then
        
        sut.tableView(sut.tableView, willDisplay: UITableViewCell(), forRowAt: indexPath)
        
        XCTAssertTrue(interactor.didLoadNextListingPage)
    }
    
    func testShouldLoadNextPageWithManySection() {
        // Given
        let sections: [SubredditSection] = [
            SubredditSection.linkRows(links: [link]),
            SubredditSection.linkRows(links: [link]),
        ]

        interactor.sections = sections

        // When
        sut.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 1)
        sut.tableView(sut.tableView, willDisplay: UITableViewCell(), forRowAt: indexPath)

        // Then
        XCTAssertTrue(interactor.didLoadNextListingPage)
    }
    
    func testUpdateListingNextPage() {
        // Given
        let links: [Link] = [link, link, link]
        let sections = [SubredditSection.linkRows(links: links)]
        interactor.sections = sections

        sut.reloadListing()
        
        // When
        interactor.sections.append(SubredditSection.linkRows(links: [link]))
        sut.updateListingNextPage()

        // Then
        XCTAssertEqual(sut.numberOfSections(in: sut.tableView), interactor.sections.count)
    }
    
    func testUploadListingNextPageWithNoListener() {
        // Given
        sut.listener = nil
        
        // When
        sut.updateListingNextPage()

        // Then
        XCTAssertEqual(sut.numberOfSections(in: sut.tableView), 0)
    }
    
    // MARK: - Present Test
    func testPresentViewController() {
        // Given
        let vc = ViewControllableMock()
        
        // When
        sut.present(viewController: vc)
        
        // Then
        XCTAssertTrue(vc.isViewLoaded)
    }
    
    func testEstimatedHeightCacheIsBeingPopulated() {
        // Given
        let sections: [SubredditSection] = [
            SubredditSection.linkRows(links: [
                link,
                link,
                link
            ])
        ]

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = UITableViewCell()
        let cellHeight: CGFloat = 100
        cell.frame = CGRect(x: 0, y: 0, width: 100, height: cellHeight)

        // When
        interactor.sections = sections
        sut.reloadListing()
        sut.tableView(sut.tableView, willDisplay: cell, forRowAt: indexPath)

        // Then
        XCTAssertEqual(sut.estimatedHeightCache[indexPath], cellHeight)
    }
    
    // MARK: - Rotation Test
    func testShouldReloadDataOnRotate() {
        // Given
        let sections: [SubredditSection] = [
            SubredditSection.linkRows(links: [
                link,
                link,
                link
                ])
        ]
        
        XCTAssertEqual(sut.numberOfSections(in: sut.tableView), 0)
        
        // When
        interactor.sections = sections
        
        // Update the bounds so that viewWillTransitionToSize will be called
        sut.view.bounds = CGRect.zero
        
        // Then
        XCTAssertEqual(sut.numberOfSections(in: sut.tableView), 1)
    }
    
    // MARK: - Title test
    func testShouldDisplayCorrectTitle() {
        // Given
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.title, "Home")
    }
}

