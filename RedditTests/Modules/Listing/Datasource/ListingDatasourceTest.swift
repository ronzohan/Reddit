//
//  ListingDatasourceTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 10/3/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxDataSources
@testable import Reddit

class ListingDatasourceTest: XCTestCase {

	lazy var tableView: UITableView = {
		return UITableView()
	}()
	
	var sut: ListingDatasource!

	var disposeBag: DisposeBag!

	override func setUp() {
		super.setUp()

		tableView.register(UrlLinkTableViewCell.self,
		                   forCellReuseIdentifier: UrlLinkTableViewCell.reuseIdentifier)
		tableView.register(ImageLinkTableViewCell.self,
		                   forCellReuseIdentifier: ImageLinkTableViewCell.reuseIdentifier)
		tableView.dataSource = self
		
		sut = ListingDatasource()

		disposeBag = DisposeBag()
	}

	func testDatasource() {
		class ListingDatasourceStub: ListingDatasource {
			var didConfigureLinkTableViewCell = false
			
			override func configureLinkTableViewCell(cell: BaseLinkTableViewCell, link: Link) {
				super.configureLinkTableViewCell(cell: cell, link: link)
				didConfigureLinkTableViewCell = true
			}
		}

		// Given
		let sut = ListingDatasourceStub()
		let urlLink = Link()
		urlLink.postHint = .link

		let imageLink = Link()
		imageLink.postHint = .image

		let sections: [ListingSection] = [
			ListingSection.linkRows(links: [
				urlLink,
				imageLink
			])
		]

		let indexPath = IndexPath(row: 0, section: 0)

		// When
		sut.dataSource.append(contentsOf: sections)
		tableView.dataSource = sut
		tableView.delegate = sut
		tableView.reloadData()
		tableView.cellForRow(at: indexPath)

		// Then
		XCTAssertTrue(sut.didConfigureLinkTableViewCell)
	}

	func testLinkTableCellIsConfigured() {
		class MockCell: BaseLinkTableViewCell {
			var didConfigure = false
			override func configure() {
				didConfigure = true
			}
		}

		// Given
		let cell = MockCell()
		let link = Link()

		// When
		sut.dataSource.append(ListingSection.linkRows(links: [link]))
		sut.configureLinkTableViewCell(cell: cell, link: link)

		// Then
		XCTAssertTrue(cell.didConfigure)
	}

	func testUrlLinkTableViewCell() {
		// Given
		let indexPath = IndexPath(row: 0, section: 0)
		let cell: UrlLinkTableViewCell?

		// When
		cell = sut.urlLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)

		// Then
		XCTAssertNotNil(cell)
	}

	func testImageLinkTableViewCell() {
		// Given
		let indexPath = IndexPath(row: 0, section: 0)
		let cell: ImageLinkTableViewCell?

		// When
		cell = sut.imageLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)

		// Then
		XCTAssertNotNil(cell)
	}

	// MARK: - Load Next Page
	func testShouldLoadNextPage() {
		// Given
		let sections: [ListingSection] = [
			ListingSection.linkRows(links: [
					Link(),
					Link(),
					Link()
				]
			)
		]

		sut.dataSource = sections

		// When
		let indexPath = IndexPath(row: 2, section: 0)
		let shouldLoad = sut.shouldLoadNextPage(withIndexPath: indexPath)
		
		// Then
		XCTAssertTrue(shouldLoad)
	}
	
	func testShouldLoadNextPageWithManySection() {
		// Given
		let sections: [ListingSection] = [
			ListingSection.linkRows(links: [Link()]),
			ListingSection.linkRows(links: [Link()])
		]
		
		sut.dataSource = sections
		
		// When
		let indexPath = IndexPath(row: 0, section: 1)
		let shouldLoad = sut.shouldLoadNextPage(withIndexPath: indexPath)
		
		// Then
		XCTAssertTrue(shouldLoad)
	}
	
	func testShouldNotLoadNextPage() {
		// Given
		let sections: [ListingSection] = [
			ListingSection.linkRows(links: [
				Link(),
				Link(),
				Link()
				]
			)
		]
		
		sut.dataSource = sections
		
		// When
		let indexPath = IndexPath(row: 0, section: 0)
		let shouldLoad = sut.shouldLoadNextPage(withIndexPath: indexPath)
		
		// Then
		XCTAssertFalse(shouldLoad)
	}
	
	func testWillDisplayCellShouldLoadNextPage() {
		// Given
		let sections: [ListingSection] = [
			ListingSection.linkRows(links: [
				Link(),
				Link(),
				Link()
				]
			)
		]
		let indexPath = IndexPath(row: 2, section: 0)
		var didLoadNextpage = false

		// When
		sut.dataSource = sections
		sut.tableView(tableView, willDisplay: UITableViewCell(), forRowAt: indexPath)
		sut.onLoadNextPage { 
			// Then
			didLoadNextpage = true
			XCTAssertTrue(didLoadNextpage)
		}
	}
	
	// MARK: - Estimated Height Caching
	func testEstimatedHeightCache() {
		// Given
		let sections: [ListingSection] = [
			ListingSection.linkRows(links: [
				Link(),
				Link(),
				Link()
				]
			)
		]
		let indexPath = IndexPath(row: 0, section: 0)
		let cell = UITableViewCell()
		let cellHeight: CGFloat = 100
		cell.frame = CGRect(x: 0, y: 0, width: 100, height: cellHeight)
		
		// When
		sut.dataSource = sections
		sut.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
		
		// Then
		XCTAssertEqual(sut.estimatedHeightCache[indexPath], cellHeight)
	}
}

// MARK: - Datasource
extension ListingDatasourceTest: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}
