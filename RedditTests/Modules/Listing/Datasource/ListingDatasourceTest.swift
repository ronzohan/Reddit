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

	var disposeBag: DisposeBag!

	override func setUp() {
		super.setUp()

		tableView.register(UrlLinkTableViewCell.self,
		                   forCellReuseIdentifier: UrlLinkTableViewCell.reuseIdentifier)
		tableView.register(ImageLinkTableViewCell.self,
		                   forCellReuseIdentifier: ImageLinkTableViewCell.reuseIdentifier)
		tableView.dataSource = self
		
		disposeBag = DisposeBag()
	}

	func testDatasource() {
		class ListingDatasourceMock: ListingDatasource {
			static var didConfigureLinkTableViewCell = false
			override class func configureLinkTableViewCell(cell: BaseLinkTableViewCell, link: Link) {
				super.configureLinkTableViewCell(cell: cell, link: link)
				didConfigureLinkTableViewCell = true
			}
		}

		// Given
		let sut = ListingDatasourceMock.datasource()
		let urlLink = Link()
		urlLink.postHint = .link

		let imageLink = Link()
		imageLink.postHint = .image

		let sections: [LinkSectionModel] = [
			LinkSectionModel.linkSection(items: [
				LinkItem.urlLink(link: urlLink),
				LinkItem.imageLink(link: imageLink)
			])
		]

		let indexPath = IndexPath(row: 0, section: 0)

		// When
		Observable.just(sections)
			.bind(to: tableView.rx.items(dataSource: sut))
			.addDisposableTo(disposeBag)

		tableView.cellForRow(at: indexPath)

		// Then
		XCTAssertTrue(ListingDatasourceMock.didConfigureLinkTableViewCell)
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
		ListingDatasource.configureLinkTableViewCell(cell: cell, link: link)

		// Then
		XCTAssertTrue(cell.didConfigure)
	}

	func testUrlLinkTableViewCell() {
		// Given
		let indexPath = IndexPath(row: 0, section: 0)
		let cell: UrlLinkTableViewCell?

		// When
		cell = ListingDatasource.urlLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)

		// Then
		XCTAssertNotNil(cell)
	}

	func testImageLinkTableViewCell() {
		// Given
		let indexPath = IndexPath(row: 0, section: 0)
		let cell: ImageLinkTableViewCell?

		// When
		cell = ListingDatasource.imageLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)

		// Then
		XCTAssertNotNil(cell)
	}
}

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
