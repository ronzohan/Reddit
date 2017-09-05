//
//  ListingPresenterTest.swift
//  Listing
//
//  Created by Ron Daryl Magno on 8/11/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class ListingPresenterTest: XCTestCase {
    
    var presenter: ListingPresenter!
    var view: ListingViewMock!
    var repository: ListingRepositoryMock!
    
    override func setUp() {
        super.setUp()
        
        view = ListingViewMock()
        repository = ListingRepositoryMock()
        
        presenter = ListingPresenter(view: view, repository: repository)
    }
    
    func testLoadListing() {
        // Given I have a presenter
        // When presenter has to load data for hot listing
        presenter.loadHotListing()
        
        // Then it should call the repository and set the view's listing
        XCTAssertTrue(repository.loadHotListingDidcall)
        XCTAssertTrue(view.setListingsDidCall)
    }
	
	func testCreateListingSections() {
		// Given I have a listing
		let listing = Listing()
		let numOfChildren = 4
		
		for _ in 0..<numOfChildren {
			listing.children.append(Link())
		}
		
		// When I create listing sections
		let sections = presenter.createListingSections(withListing: listing)
		
		// Then the sections 
		XCTAssertEqual(sections.count, 1)
		XCTAssertEqual(sections[0].type, .link)
		XCTAssertTrue(sections[0] is LinkSection)
		
		guard let linkSection = sections[0] as? LinkSection else {
			assertionFailure("Section is not Link Section")
			return
		}
		
		XCTAssertEqual(linkSection.rowCount, numOfChildren)
	}
	
	func testUpdateLinkCellHeight() {
		// Given I have a link 
		let link = Link()
		let image = Image()
		
		let imageInfo = ImageInfo()
		imageInfo.height = 400
		imageInfo.width = 200
		imageInfo.url = "www.google.com"
		
		image.source = imageInfo
		
		link.preview.images.append(image)
		
		let linkCellMock = LinkCellMock()
		
		// When I set the height of the link cell
		presenter.updateLinkCell(linkCell: linkCellMock, withLink: link)
		
		// Then the link cell should have been updated
		XCTAssertTrue(linkCellMock.updateCellHeightCalled)
		XCTAssertTrue(linkCellMock.updateTitleCalled)
		XCTAssertTrue(linkCellMock.updateImageCalled)
	}
}
